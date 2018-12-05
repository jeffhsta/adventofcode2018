defmodule Day2 do
  def checksum(box_ids) do
    box_ids
    |> Enum.map(&count_duplicates/1)
    |> sum_duplicates()
    |> calculate_checksum()
  end

  def find_similar_box_id([first_id | rest]) do
    with [result | _] <- compare_ids(first_id, rest, []),
         {first_id, second_id} <- result do
      first_id_arr = first_id |> String.split("") |> Enum.filter(&(&1 != ""))
      second_id_arr = second_id |> String.split("") |> Enum.filter(&(&1 != ""))

      first_id_arr
      |> Enum.zip(second_id_arr)
      |> Enum.reduce("", fn cur, acc ->
        with {a, a} <- cur do
          acc <> a
        else
          _ -> acc
        end
      end)
    else
      _ -> []
    end
  end

  defp compare_ids(_, [], similar_found), do: similar_found
  defp compare_ids(current_id, arr = [next_id | rest], similar_found) do
    similar = Enum.reduce(arr, [], fn item, list ->
      with {true, first_id, second_id} <- is_similar(current_id, item) do
        [{first_id, second_id} | list]
      else
        _ -> list
      end
    end)

    compare_ids(next_id, rest, similar_found ++ similar)
  end

  defp is_similar(first_id, second_id) do
    first_id_arr = first_id |> String.split("") |> Enum.filter(&(&1 != ""))
    second_id_arr = second_id |> String.split("") |> Enum.filter(&(&1 != ""))

    convergence_count =
      first_id_arr
      |> Enum.zip(second_id_arr)
      |> Enum.filter(&(elem(&1, 0) == elem(&1, 1)))
      |> Enum.count()

    is_similar = convergence_count >= String.length(first_id) - 1
    {is_similar, first_id, second_id}
  end

  defp count_duplicates(box_id) do
    box_id
    |> String.split("")
    |> Enum.filter(&(&1 != ""))
    |> Enum.reduce(%{}, fn letter, state ->
      count = Map.get(state, letter, 0)
      Map.put(state, letter, count + 1)
    end)
    |> map_2_and_3_letter_duplication()
  end

  defp map_2_and_3_letter_duplication(data) do
    data
    |> Map.keys()
    |> Enum.reduce({false, false}, fn key, {letter2_count, letter3_count} ->
      data
      |> Map.get(key)
      |> case do
        2 -> {true, letter3_count}
        3 -> {letter2_count, true}
        _ -> {letter2_count, letter3_count}
      end
    end)
  end

  defp sum_duplicates(data_list) do
    letter2_count = data_list |> Enum.filter(fn {letter2, _} -> letter2 end) |> Enum.count()
    letter3_count = data_list |> Enum.filter(fn {_, letter3} -> letter3 end) |> Enum.count()

    {letter2_count, letter3_count}
  end

  defp calculate_checksum({letter2_count, letter3_count}) do
    letter2_count * letter3_count
  end
end

input = [
  "nkucgflathzwwijtrevymbdplq",
  "nkucgflathzwsidxrlvymbdpiq",
  "nkucgjlathqwsijxrevymbypoq",
  "nkucgflarrzwsmjxrevymbdpoq",
  "nkucgflzthtwsijxrevymbdpjq",
  "nkucgflahhzwskjxrevymbgpoq",
  "bkycgflathzwsijxrsvymbdpoq",
  "nkucgflathzwsijxdevymbdmog",
  "nkucgflaehzwsmjxrevymbdpow",
  "nkucgflathzwsijxrevwmbdnbq",
  "nkucgflathzssijxrevynbdqoq",
  "ngucgflathzwsijxsevymndpoq",
  "nfucgflathzvsijxrevymbspoq",
  "nkucgflwthzwsijxreeymbdpkq",
  "nkucgflpthzwsijxrevdmbdpoe",
  "nkungflatuzwsijurevymbdpoq",
  "nkucgflathzwsiqxrevyybdpom",
  "nkucgflathzwsicxrevtmbtpoq",
  "nkucgfladhzwsijxreuymbdboq",
  "nkumgflathznsijxzevymbdpoq",
  "nkuagflethzwsijxrqvymbdpoq",
  "nkucgflatozwhijxrevymbdpkq",
  "nkuggflathzwsijxrejymbdpob",
  "nkucgflathzwlijxrqvambdpoq",
  "hkucnflathzasijxrevymbdpoq",
  "nkuigflathzwsirxrevymbdooq",
  "nkucgflatezwsijxwetymbdpoq",
  "nkucmflavhbwsijxrevymbdpoq",
  "nkucgflathzwssjxrevytbmpoq",
  "nkucgflmthzwsvjxrevymbdpgq",
  "nkucgtlathzwsijcrevymbjpoq",
  "nkucgflathfwsfjxrevymbdpsq",
  "nkucgflathjwsijxrwvymbdpok",
  "nkucgeldthzwsijxrevymqdpoq",
  "nkutgcpathzwsijxrevymbdpoq",
  "nkucgflaehzmsijxrevymydpoq",
  "mkucdflathzwsvjxrevymbdpoq",
  "nkucgflathzwsijxtevymidpfq",
  "nkucgfllthzwsijirevlmbdpoq",
  "nkucgfuathzwsijxrevymbqpou",
  "nkufgflathzwsijxrgvymbdpor",
  "nkuygflatrzwsijxrevymbdpoo",
  "nkunoflathzwsijxrevyabdpoq",
  "nksogflathzwsijxrevymbdpeq",
  "nkucgflathzwciexrevymbdhoq",
  "nkucgfnathzwsijxdevyobdpoq",
  "nkudgflazhzwsijxrevymbmpoq",
  "nkucgylathzwscjxrevymbdaoq",
  "nkucgflqthzisijxrerymbdpoq",
  "nkucgxlathzwsijxgebymbdpoq",
  "nkucgflathzssijxrwvymadpoq",
  "nkucgflathzwsijxrvvymbdloi",
  "nkucaflathzwskjxzevymbdpoq",
  "wkuchflathzwsijxrevymbdioq",
  "nkucgilathzwsijxrgvympdpoq",
  "nkubgflaohzwsijxrevymbnpoq",
  "nkucgwoathzwnijxrevymbdpoq",
  "nkprgflathzwsijxrevywbdpoq",
  "nkucgflatlzwsijxievymzdpoq",
  "nkucgflathzwsijxrevymbmdow",
  "nkucgzlathzwsitlrevymbdpoq",
  "nkubgfladhzwsijxrevymbdpsq",
  "nkucgflathzwsijxrzvyibdroq",
  "wkucgflathznsijqrevymbdpoq",
  "nkupgilathzwsijxrnvymbdpoq",
  "nkucgflathzwwijnrevymgdpoq",
  "nkucgflathjwsijxrewymbopoq",
  "mkwcdflathzwsvjxrevymbdpoq",
  "nkucgflathzwsujxoevymbdboq",
  "nkucvflathzwsojxrevymzdpoq",
  "nkocgflabhzwsijxrevyebdpoq",
  "skuciflpthzwsijxrevymbdpoq",
  "nkuxgflathzrsijxrevymbupoq",
  "nkucgblathzwsezxrevymbdpoq",
  "nkucgflathzwsijxrevymbvtop",
  "nkucdflathzwsiaxrefymbdpoq",
  "nkucgflathzwsijxzevkmbdpmq",
  "nkucgflarhzwsijroevymbdpoq",
  "nkuccflathzwsinxrevymsdpoq",
  "nkucgflathzwsijxregymidsoq",
  "nkucgflathnwsijxrvvumbdpoq",
  "nkucgfaathzwssjxrevymbdwoq",
  "nkucgflothzwsijxrevymbdloz",
  "naucgulathzwsijxremymbdpoq",
  "nkucgflaqhzwsijxrevymbdnqq",
  "wkucgflatrzwsijxrevymbdpof",
  "nvucgflaehzwyijxrevymbdpoq",
  "nkusaflaahzwsijxrevymbdpoq",
  "nkucgfkathzwsijxrevymbdbfq",
  "nkucgfkathzwsijrrevymodpoq",
  "nkuegflathzwsijxrrvbmbdpoq",
  "ykucgflathzwsijfrlvymbdpoq",
  "nkucgflathzrsujxrevymbdkoq",
  "nkuclflatsowsijxrevymbdpoq",
  "nkucgflathzwsgjxrqvymbdpor",
  "ekucgflathzwsijorevlmbdpoq",
  "nkucgflathizsijgrevymbdpoq",
  "nkucgfoathzksijbrevymbdpoq",
  "nkucgflachzwsijxrevymbupoa",
  "nkuhgflathzwsijxravylbdpoq",
  "nkncgflithzwsijnrevymbdpoq",
  "nvucgjlathzjsijxrevymbdpoq",
  "nhucgflathzwsijxrtvymbtpoq",
  "akucgflathzwhijxrevymbdpor",
  "nkucgflatozisijxrvvymbdpoq",
  "nkucgzlatgzwsijxrevymbepoq",
  "nkjcgflqthmwsijxrevymbdpoq",
  "nkucgflaohzosijxrhvymbdpoq",
  "ntucgflatrzwsijxrevymbdpol",
  "nkucgflathzwsijkriqymbdpoq",
  "nkuggflathzwsijmrevymbdpvq",
  "nkucgflpmhzwsmjxrevymbdpoq",
  "okucgflathzwsijxrevgmbdsoq",
  "nkucgflaehzwkijxrevymwdpoq",
  "zkucgfllthzwsijxrevymbdpod",
  "nkicgflathzasijxfevymbdpoq",
  "kkucgfhathzwsijxaevymbdpoq",
  "nkucqflsthzwsijxrevyjbdpoq",
  "nkucgflaghzwsijxoevykbdpoq",
  "nkucgflaohzwsljxryvymbdpoq",
  "bkucfflathzwsijxrexymbdpoq",
  "nkucnflathzwsbjxrpvymbdpoq",
  "nkucjflatlzwsijxrevymqdpoq",
  "nkucgflathzwsijsyevyxbdpoq",
  "nkwcgflathzosijxqevymbdpoq",
  "nkucgslathzesijxievymbdpoq",
  "nkuciflauhzwsiaxrevymbdpoq",
  "nkucgflathzwsiwxreeymbdwoq",
  "nkucgblatwzwsijxkevymbdpoq",
  "njucgfkathzwsijxrevymbvpoq",
  "nkucgfladhzwsijfrevyibdpoq",
  "nkukgflathzwsijprenymbdpoq",
  "nkucgflathzwsijxrchymbupoq",
  "nkucgfeathzwsitxaevymbdpoq",
  "nkufjflathzwsijxresymbdpoq",
  "nkuggflatlzwsijxrevymbdpoa",
  "nkucgflsthnwsijxrevumbdpoq",
  "nkuceflathzwsnjxrevymbmpoq",
  "nkucgflabhzwsijxrevymblplq",
  "nkucgfmathzwsijxrevdybdpoq",
  "niuvgflathzwsijxrcvymbdpoq",
  "nkscgflathzwsijxrevyzbdooq",
  "nkucgflatszwsbjxrevymbgpoq",
  "nkucgflazhzwsijxcevymzdpoq",
  "nkucgflathzwsfjqrevymbdpxq",
  "nkucgflathcwsijxrrvymbdroq",
  "nkurgflathzwsijxrepymzdpoq",
  "nlucgflathzwrijxrevdmbdpoq",
  "kkucgflkthzwswjxrevymbdpoq",
  "nktcgflathzwgijxrevbmbdpoq",
  "nbucgfiathzwsijxreyymbdpoq",
  "lkucgflathswsijxrevymbdpxq",
  "ntucgflathzwswrxrevymbdpoq",
  "nkscgflathzwssjxravymbdpoq",
  "nuocgflathzwsijxrevyebdpoq",
  "nbucgllathzwsijxregymbdpoq",
  "ckucbflathzwsijxrelymbdpoq",
  "nkucgflathzwsijxremymbqpor",
  "nkgcgfljthzwsijkrevymbdpoq",
  "nkdcgflashzwsijxrjvymbdpoq",
  "nkecgflathzwsijxuevumbdpoq",
  "njucgflatpfwsijxrevymbdpoq",
  "nkucgwlathzjsijxrevymbzpoq",
  "nkucgfxathzqsijxrenymbdpoq",
  "dkfcgflathzwsijxrevymbdtoq",
  "nkupgfhathzwsijxrevymbjpoq",
  "nkucgflathzwsjjxrevymldooq",
  "pkucgfbathhwsijxrevymbdpoq",
  "nkuciflayhzwsijxrevymbdpfq",
  "nkucpfdathzwsajxrevymbdpoq",
  "ykucgflathdwsijzrevymbdpoq",
  "nkucgwlstnzwsijxrevymbdpoq",
  "nkucwfzazhzwsijxrevymbdpoq",
  "nkucgflatczwssjxretymbdpoq",
  "nkucgflathzwsijpreaymxdpoq",
  "ntucgflathzwsijxrepymvdpoq",
  "nkucgqlathzdsijxrevymbopoq",
  "nkucgflathzusijxfevymbdptq",
  "nkocgflathzwdijxrevymbipoq",
  "nklcgflatgzwsijxrevymbdsoq",
  "nkucgflathzwsgjxgevymbopoq",
  "nkucgflathzwuijxreaymbdyoq",
  "nkucgwlathzwsvjxrevymbdpos",
  "nkucrflathzwliqxrevymbdpoq",
  "nkucgflathzxsijxievysbdpoq",
  "nkufgolhthzwsijxrevymbdpoq",
  "niucgflathzwsiixrevyabdpoq",
  "nkucgflathzhsijxrevymbdyuq",
  "nkucgqlathzwsijxreaymbdpob",
  "nzucgflathzesijxrevymwdpoq",
  "nkucgflatlzwsirxrevymmdpoq",
  "nkucgfxavhzwsijxrevymbwpoq",
  "nkucgflathswsijxrevvmbdpoe",
  "nkucgfgethzwsrjxrevymbdpoq",
  "nkucgzlayhzwsinxrevymbdpoq",
  "nkucgflwthzwsiyxrevymbdpdq",
  "nkucgflpthzwsijxrezombdpoq",
  "nkurgflathdwsijxuevymbdpoq",
  "nkjcgflathzwsijxrevkmbdpoc",
  "nkucmflatuzwsijxrevmmbdpoq",
  "nkucgfldthzwsijxrevevbdpoq",
  "nkucgflatrzgsijxrevambdpoq",
  "nkicgflathzwsijxrevymhdhoq",
  "nkbcgflathzwsijxrevymxdpos",
  "nkucgflatfzwsijxrevymwdqoq",
  "hkucgflaqwzwsijxrevymbdpoq",
  "nkjcgflathzvsijxrevyjbdpoq",
  "niucgflathzwsijxrezymbdpob",
  "ynucgflathzwsijxremymbdpoq",
  "nkubgflathzwsijxrhvymldpoq",
  "nkucqflrthzesijxrevymbdpoq",
  "nkucgulathzwsijxrevyubdioq",
  "nkuczflathzwsijxaebymbdpoq",
  "nkucgfldthzwsibxrevymrdpoq",
  "nkucgflatwzdsijxrevymsdpoq",
  "nkncgffathzwsijxrejymbdpoq",
  "nkucgflathzqsijxrevxmodpoq",
  "nkucgflathwwsijqrevymbipoq",
  "nkucgflathzwhajxrebymbdpoq",
  "gkucgflathzwsijxreirmbdpoq",
  "nkucgflathzesijzravymbdpoq",
  "nkucgflaghzwsijxrerymbdplq",
  "wkucgflathxwgijxrevymbdpoq",
  "nkucgfljthfwsijxrevymbdpfq",
  "nkucgflathwwsimxrevymbdpjq",
  "nkucgdlachzwsijxrevymmdpoq",
  "njucgclathzwsiixrevymbdpoq",
  "nkucgflatdzwsijxrevymzrpoq",
  "nkuckflatvzcsijxrevymbdpoq",
  "nkucgflathzhsijxrevqmbkpoq",
  "nkucqflathzjsijvrevymbdpoq",
  "nkucgftathzwsijxrevympdpoi",
  "nvucgflatmzwsijxrevymbdpsq",
  "nkocgflathznsijxrevymbdphq",
  "mkgcgflathzwsijxrevymbdpvq",
  "nkucnflathzwsijbrevymbdcoq",
  "nkucgflathzwsijsrevymsdgoq",
  "nkuckflatxzwsiwxrevymbdpoq",
  "nkucyflathzwsijxrehcmbdpoq",
  "nkurgflajhzwsijxrevkmbdpoq",
  "wkucgflathzwsijxrfvymbapoq",
  "nkucgflathzwsijxaekymbdpon",
  "nkucgfkathywsijxrevymbdpsq",
  "nkucgflathzwsijxaexcmbdpoq",
  "nkucgflathzwsijxrevymddhox",
  "nkucgflathzwgijxrevymydooq",
  "nkycqflathzwsijxrezymbdpoq",
  "nkucgflathwwsijxrevymbspsq",
  "nkucgflatpzwssjfrevymbdpoq",
  "nkwcgflhthzwsijxrevcmbdpoq",
]

input
|> Day2.checksum()
|> IO.inspect(label: "Day 2 Part 1")

input
|> Day2.find_similar_box_id()
|> IO.inspect(label: "Day 2 Part 2")

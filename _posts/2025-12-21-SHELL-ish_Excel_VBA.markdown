---
layout: post
category: excel
title: "SHELL-ish Excel VBA"
---

Excel VBAを扱う。Excel VBAの制限した使い型（方）を説明する。
下に記載しているプログラムは、実行環境が無いため動作確認していない。

## SHELL-ish Excel VBA

***SHELL-ish（シェリッシュ） Excel VBA***は、造語である。SHELL-ishであることから、シェルのようにテキストを扱うイメージ。インプットをテキストとして、アウトプットをテキストファイルとする。

シェルのパイプで繋いだ標準出力をリダイレクトでファイル出力するイメージを、Excel VBAで行う。あくまでもイメージ。

シート`input`に元データを入力し、その情報を元に、処理結果をシート`output`に出力する。シート`output`の内容をファイル出力する。

### ルール

- シートは、`A列`のみ使用する。他の列は使用しない。
- アウトプットは、テキストファイル
  -  テキストファイルの内容は、一度、シートに出力する。その上で、テキストファイルに出力する。

## 使い方

1. シート`input`を作る。
1. シート`input`にインプットテキストを入力する。
1. シート`output`を作る。
1. "処理部分"を実装する。
1. マクロを実行する。

## 型：プログラム全体

```vb
Sub proc_xxxx()
  ''' [A. 入力部分]
  ''' シートinputのA列の行数を数える。
  Dim input_ws As Worksheet: Set input_ws = Sheets("input")
  Dim max_row As Long: max_row = input_ws.Cells(Rows.Count, 1).End(xlUp).Row


  ''' [B. 出力シート準備部分]
  ''' 前回の出力が混じらないように、出力シートを初期化（セル全消去）する。
  Dim output_ws As Worksheet: Set output_ws = Sheets("output")
  output_ws.Cells.Clear 


  ''' [C. 処理部分]
  ''' inputを処理した内容を、outputに出力する。
  Dim y As Long: y = 1
  Dim i As Long
  For i = 1 To max_row
    line = input_ws.Cells(i, 1).Value

    ''' TODO:
    ''' inputのlineについて、処理を行う。
    ''' output_ws(y, 1).Valueに、処理した内容を入れていく。
    output_ws.Cells(y, 1).Value = 
    ''' output_wsに値を入れたあと、yをインクリメントしていく。
    y = y + 1
  Next i


  ''' 出力するシート名と出力ファイル名を指定する。
  ''' ファイル名が相対パスの場合は、ドキュメントフォルダへ出力する。
  Call write_file("output", "output.txt")
End Sub


Sub write_file(ByVal sheet_name As String, ByVal output_filename As String)
  Dim output_ws As Worksheet: Set output_ws = Sheets(sheet_name)

  Dim output_max_row As Long: output_max_row = output_ws.Cells(Rows.Count, 1).End(xlUp).Row

  Dim j As Long
  Open output_filename For Output As #1
  For j = 1 To output_max_row
    Print #1, output_ws.Cells(j, 1).Value
  Next j
  Close #1
End Sub
```

- `proc_xxxx`部分は好きな文字に書き換える。
- 同じ方法で、別の処理を加える場合は、`proc_xxxx`関数をコピーして、`[C. 処理部分]`の処理箇所を変更・書き換える。
  - （本当は、Rubyのブロック引数としてメソッドに渡すようなことをやりたい）。

### その他

- A列しか使用しない。つまり`Cells(y, 1)`の第二引数は必ず`1`になる。
- 文字列の合致比較・条件分岐は、`If str Like "*World" Then`など、`Like`が役立つ。
- 処理箇所、およびファイル出力箇所は、別々とする。計算量は多くなるが、プログラムを簡潔にするため、この構成とする。
- =から始まる行を扱ったときの挙動が不明
- Excelをのセルに置く必要あるか？


2025年 12月21日 日曜日 21時52分59秒 JST

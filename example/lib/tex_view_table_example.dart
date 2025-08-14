import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewTableExample extends StatefulWidget {
  const TeXViewTableExample({super.key});

  @override
  State<TeXViewTableExample> createState() => _TeXViewTableExampleState();
}

class _TeXViewTableExampleState extends State<TeXViewTableExample> {
  String selectedFormula = "아직 아무것도 선택되지 않았습니다.";
  int selectedRow = -1;
  int selectedCol = -1;

  // 수식 데이터 (3x4 테이블)
  final List<List<Map<String, String>>> formulaTable = [
    [
      {"id": "0_0", "title": "피타고라스", "formula": r"a^2 + b^2 = c^2"},
      {"id": "0_1", "title": "아인슈타인", "formula": r"E = mc^2"},
      {"id": "0_2", "title": "오일러 공식", "formula": r"e^{i\pi} + 1 = 0"},
      {"id": "0_3", "title": "원의 넓이", "formula": r"A = \pi r^2"},
    ],
    [
      {
        "id": "1_0",
        "title": "이차방정식",
        "formula": r"x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}"
      },
      {
        "id": "1_1",
        "title": "미분공식",
        "formula": r"\frac{d}{dx}(x^n) = nx^{n-1}"
      },
      {
        "id": "1_2",
        "title": "적분공식",
        "formula": r"\int x^n dx = \frac{x^{n+1}}{n+1} + C"
      },
      {
        "id": "1_3",
        "title": "로그법칙",
        "formula": r"\log_a(xy) = \log_a x + \log_a y"
      },
    ],
    [
      {
        "id": "2_0",
        "title": "삼각함수",
        "formula": r"\sin^2\theta + \cos^2\theta = 1"
      },
      {
        "id": "2_1",
        "title": "테일러 급수",
        "formula": r"f(x) = \sum_{n=0}^{\infty} \frac{f^{(n)}(a)}{n!}(x-a)^n"
      },
      {
        "id": "2_2",
        "title": "가우스 적분",
        "formula": r"\int_{-\infty}^{\infty} e^{-x^2} dx = \sqrt{\pi}"
      },
      {
        "id": "2_3",
        "title": "바젤 문제",
        "formula": r"\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{\pi^2}{6}"
      },
    ],
  ];

  void onFormulaSelected(String id, String title, String formula) {
    // ID에서 행과 열 추출
    List<String> parts = id.split('_');
    int row = int.parse(parts[0]);
    int col = int.parse(parts[1]);

    setState(() {
      selectedFormula = "$title: $formula";
      selectedRow = row;
      selectedCol = col;
    });

    // 스낵바로 선택된 항목 표시
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('선택됨: $title (행: ${row + 1}, 열: ${col + 1})'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "수학 공식 테이블",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 선택된 항목 표시 영역
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue, width: 2),
            ),
            child: Column(
              children: [
                const Text(
                  "선택된 공식:",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedFormula,
                  style: const TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                if (selectedRow >= 0 && selectedCol >= 0)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      "위치: ${selectedRow + 1}행 ${selectedCol + 1}열",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // 테이블 영역
          Expanded(
            child: TeXView(
              child: TeXViewColumn(
                children: [
                  TeXViewDocument(
                    r"""
                    <div style="text-align: center; margin: 10px;">
                      <h3>수학 공식 테이블</h3>
                      <p>각 공식을 클릭해보세요!</p>
                    </div>
                    """,
                    style: const TeXViewStyle(
                      margin: TeXViewMargin.all(10),
                    ),
                  ),

                  // 테이블 행들 생성
                  ...formulaTable.asMap().entries.map((rowEntry) {
                    int rowIndex = rowEntry.key;
                    List<Map<String, String>> row = rowEntry.value;

                    return TeXViewRow(
                      children: row.asMap().entries.map((colEntry) {
                        int colIndex = colEntry.key;
                        Map<String, String> cellData = colEntry.value;

                        bool isSelected =
                            selectedRow == rowIndex && selectedCol == colIndex;

                        return TeXViewInkWell(
                          id: cellData["id"]!,
                          child: TeXViewDocument(
                            '''
                            <div style="text-align: center; padding: 10px;">
                              <h4 style="margin: 5px 0; color: #333;">${cellData["title"]}</h4>
                              <div style="margin: 10px 0;">
                                \$\$${cellData["formula"]}\$\$
                              </div>
                            </div>
                            ''',
                            style: TeXViewStyle(
                              width: 200,
                              height: 200,
                              backgroundColor: isSelected
                                  ? Colors.blue[100]
                                  : Colors.grey[50],
                              padding: const TeXViewPadding.all(15),
                              margin: const TeXViewMargin.all(5),
                              borderRadius: const TeXViewBorderRadius.all(10),
                              border: TeXViewBorder.all(
                                TeXViewBorderDecoration(
                                  borderColor: isSelected
                                      ? Colors.blue
                                      : Colors.grey[300]!,
                                  borderStyle: TeXViewBorderStyle.solid,
                                  borderWidth: isSelected ? 3 : 1,
                                ),
                              ),
                            ),
                          ),
                          onTap: (id) {
                            onFormulaSelected(
                              id,
                              cellData["title"]!,
                              cellData["formula"]!,
                            );
                          },
                        );
                      }).toList(),
                    );
                  }).toList(),

                  // 사용법 안내
                  TeXViewDocument(
                    r"""
                    <div style="margin: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 10px; border: 1px solid #dee2e6;">
                      <h4>사용법</h4>
                      <ul>
                        <li>각 공식 카드를 클릭하면 상단에 선택된 공식이 표시됩니다</li>
                        <li>선택된 카드는 파란색 테두리로 강조됩니다</li>
                        <li>스낵바를 통해 선택된 항목의 위치를 확인할 수 있습니다</li>
                        <li>TeXViewRow와 TeXViewInkWell을 활용한 인터랙티브 테이블입니다</li>
                      </ul>
                    </div>
                    """,
                    style: const TeXViewStyle(
                      margin: TeXViewMargin.all(15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TeXViewRowExample extends StatelessWidget {
  const TeXViewRowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "TeXView Row Examples",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: TeXView(
        child: TeXViewColumn(
          children: [
            TeXViewDocument(
              r"""
              <h2>TeXViewRow 사용 예제</h2>
              <p>TeXViewRow는 여러 요소들을 수평으로 배치할 때 사용합니다.</p>
              """,
              style: const TeXViewStyle(
                margin: TeXViewMargin.all(10),
              ),
            ),

            // 예제 1: 수식들을 가로로 배치
            TeXViewDocument(
              "<h3>예제 1: 수식 가로 배치</h3>",
              style: const TeXViewStyle(
                margin: TeXViewMargin.only(top: 20, left: 10, right: 10),
              ),
            ),
            TeXViewRow(
              children: [
                TeXViewDocument(
                  r"$$E = mc^2$$",
                  style: TeXViewStyle(
                    backgroundColor: Colors.lightBlue,
                    padding: const TeXViewPadding.all(10),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(5),
                  ),
                ),
                TeXViewDocument(
                  r"$$a^2 + b^2 = c^2$$",
                  style: TeXViewStyle(
                    backgroundColor: Colors.lightGreen,
                    padding: const TeXViewPadding.all(10),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(5),
                  ),
                ),
                TeXViewDocument(
                  r"$$\pi = 3.14159...$$",
                  style: TeXViewStyle(
                    backgroundColor: Colors.orange,
                    padding: const TeXViewPadding.all(10),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(5),
                  ),
                ),
              ],
            ),

            // 예제 2: 텍스트와 수식 혼합
            TeXViewDocument(
              "<h3>예제 2: 텍스트와 수식 혼합</h3>",
              style: const TeXViewStyle(
                margin: TeXViewMargin.only(top: 20, left: 10, right: 10),
              ),
            ),
            TeXViewRow(
              children: [
                TeXViewDocument(
                  "<p><strong>아인슈타인의 질량-에너지 공식:</strong></p>",
                  style: TeXViewStyle(
                    backgroundColor: Colors.grey[100],
                    padding: const TeXViewPadding.all(15),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(10),
                  ),
                ),
                TeXViewDocument(
                  r"$$E = mc^2$$",
                  style: TeXViewStyle(
                    backgroundColor: Colors.yellow[100],
                    padding: const TeXViewPadding.all(15),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(10),
                  ),
                ),
              ],
            ),

            // 예제 3: 복잡한 레이아웃 (Row + Column)
            TeXViewDocument(
              "<h3>예제 3: Row와 Column 조합</h3>",
              style: const TeXViewStyle(
                margin: TeXViewMargin.only(top: 20, left: 10, right: 10),
              ),
            ),
            TeXViewRow(
              children: [
                TeXViewColumn(
                  children: [
                    TeXViewDocument(
                      "<h4>삼각함수</h4>",
                      style: TeXViewStyle(
                        backgroundColor: Colors.purple[100],
                        padding: const TeXViewPadding.all(10),
                        margin: const TeXViewMargin.all(5),
                        borderRadius: const TeXViewBorderRadius.all(5),
                      ),
                    ),
                    TeXViewDocument(
                      r"$$\sin^2\theta + \cos^2\theta = 1$$",
                      style: TeXViewStyle(
                        backgroundColor: Colors.purple[50],
                        padding: const TeXViewPadding.all(10),
                        margin: const TeXViewMargin.all(5),
                        borderRadius: const TeXViewBorderRadius.all(5),
                      ),
                    ),
                  ],
                ),
                TeXViewColumn(
                  children: [
                    TeXViewDocument(
                      "<h4>미분공식</h4>",
                      style: TeXViewStyle(
                        backgroundColor: Colors.teal[100],
                        padding: const TeXViewPadding.all(10),
                        margin: const TeXViewMargin.all(5),
                        borderRadius: const TeXViewBorderRadius.all(5),
                      ),
                    ),
                    TeXViewDocument(
                      r"$$\frac{d}{dx}(x^n) = nx^{n-1}$$",
                      style: TeXViewStyle(
                        backgroundColor: Colors.teal[50],
                        padding: const TeXViewPadding.all(10),
                        margin: const TeXViewMargin.all(5),
                        borderRadius: const TeXViewBorderRadius.all(5),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // 예제 4: 세 개의 동등한 크기 요소
            TeXViewDocument(
              "<h3>예제 4: 균등 분할</h3>",
              style: const TeXViewStyle(
                margin: TeXViewMargin.only(top: 20, left: 10, right: 10),
              ),
            ),
            TeXViewRow(
              children: [
                TeXViewDocument(
                  r"""
                  <div style="text-align: center;">
                    <h4>기하학</h4>
                    $$A = \pi r^2$$
                  </div>
                  """,
                  style: TeXViewStyle(
                    backgroundColor: Colors.red[100],
                    padding: const TeXViewPadding.all(15),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(10),
                    border: const TeXViewBorder.all(
                      TeXViewBorderDecoration(
                        borderColor: Colors.red,
                        borderStyle: TeXViewBorderStyle.solid,
                        borderWidth: 2,
                      ),
                    ),
                  ),
                ),
                TeXViewDocument(
                  r"""
                  <div style="text-align: center;">
                    <h4>대수학</h4>
                    $$x = \frac{-b \pm \sqrt{b^2-4ac}}{2a}$$
                  </div>
                  """,
                  style: TeXViewStyle(
                    backgroundColor: Colors.green[100],
                    padding: const TeXViewPadding.all(15),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(10),
                    border: const TeXViewBorder.all(
                      TeXViewBorderDecoration(
                        borderColor: Colors.green,
                        borderStyle: TeXViewBorderStyle.solid,
                        borderWidth: 2,
                      ),
                    ),
                  ),
                ),
                TeXViewDocument(
                  r"""
                  <div style="text-align: center;">
                    <h4>미적분</h4>
                    $$\int_a^b f(x)dx$$
                  </div>
                  """,
                  style: TeXViewStyle(
                    backgroundColor: Colors.blue[100],
                    padding: const TeXViewPadding.all(15),
                    margin: const TeXViewMargin.all(5),
                    borderRadius: const TeXViewBorderRadius.all(10),
                    border: const TeXViewBorder.all(
                      TeXViewBorderDecoration(
                        borderColor: Colors.blue,
                        borderStyle: TeXViewBorderStyle.solid,
                        borderWidth: 2,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            TeXViewDocument(
              r"""
              <h3>사용법</h3>
              <p>TeXViewRow를 사용하면 위와 같이 여러 요소들을 수평으로 배치할 수 있습니다.</p>
              <p>TeXViewColumn과 조합하여 더 복잡한 레이아웃도 구성할 수 있습니다.</p>
              """,
              style: TeXViewStyle(
                margin: const TeXViewMargin.all(15),
                backgroundColor: Colors.grey[50],
                padding: const TeXViewPadding.all(15),
                borderRadius: const TeXViewBorderRadius.all(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

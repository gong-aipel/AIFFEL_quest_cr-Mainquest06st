import 'dart:async'; // �񵿱� �۾��� ���� Timer ���̺귯�� �߰�
                     // async : await�� ����� �񵿱� �Լ���
                     // �����ϴ� Ű����. �� �Լ��� ��ȯŸ���� �׻� Future�̴�.
                     // https://genius-duck-coding-story.tistory.com/290

class PomodoroTimer {
  int workDuration = 25; // �۾� �ð� : (25��) * 60 =  (25��) �� (25��)
  int shortBreak = 5;   // ª�� �޽� �ð� : (5��) * 60 = (5��) �� (5��)
  int longBreak = 15;   // �� �޽� �ð� (15��) * 60 =  (15��) �� (15��)
  int cycle = 4; // 4ȸ������ �� �޽� ����
  int currentCycle = 0; // ���� ���� ���� ����Ŭ Ƚ��
  bool isWorking = true; // ���� �۾� ������ ����
  Timer? timer; // Timer ��ü ����, ���� p.85 ����, �� ���(?)

  // Ÿ�̸� ���� �Լ�(�޼ҵ�)
  void startTimer() {
    // ���� ���(�۾�/�޽�)�� ���� �ð� ����
    // ���׿����� ��ø ���, https://blog.naver.com/kyg1022/223154013342 ����
    int duration =
        isWorking
        ? workDuration 
        : (currentCycle == cycle - 1 ? longBreak : shortBreak);

    // 1�ʸ��� ����Ǵ� Ÿ�̸� ����, Timer Ŭ���� ���, �ν��ϼ� ���� timer ȣ��
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (duration <= 0) { // �ð��� ����Ǹ�
        timer.cancel(); // Ÿ�̸� ����
        switchMode(); // ��� ���� (�۾� <-> �޽�)
      } else {
        duration--; // ���� �ð� 1�� ����
        printTime(duration); // ���� �ð� ���
      }
    }); // ��ȣ ��ġ �����ؾ� ��, �鿩���� ���߱�
  }

  // �۾� <-> �޽� ��� ���� �Լ�(�޼ҵ�)
  void switchMode() {
    isWorking = !isWorking; // �۾� <-> �޽� ���� ��ȯ, �Ҹ��� �ڷ���

    // �۾��� ������ �޽����� ��ȯ�� �� ����Ŭ ����
    if (!isWorking) {
      currentCycle = (currentCycle + 1) % cycle;
    }

    startTimer(); // ���ο� ���� Ÿ�̸� ����, �޼ҵ� ȣ�� 
  }

  // ���� �ð��� mm:ss �������� ����ϴ� �Լ�
  void printTime(int seconds) {
    // �� ���,���� ���ϴ� ������(~/) �̿�,https://brunch.co.kr/@mystoryg/120 ����
    int minutes = seconds ~/ 60;
    // �� ���, ������ ������(%) �̿�
    int secs = seconds % 60;
    // �� �ڸ� �� ���� ���, https://code-lab.tistory.com/1334 ����
    print('$minutes:${secs.toString().padLeft(2, '0')}'); 
  }
} // Ŭ���� ����

void main() {
  PomodoroTimer pomodoro = PomodoroTimer(); // PomodoroTimer ��ü ����
  pomodoro.startTimer(); // Ÿ�̸� ����
}
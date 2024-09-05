export class UniqueRandomGenerator {
  private usedNumbers: Set<number> = new Set();

  getRandomInt(min: number, max: number): number {
    min = Math.ceil(min);
    max = Math.floor(max);

    if (max - min + 1 <= this.usedNumbers.size) {
      // 如果可用的数字已经全部用过，则重置已使用的数字集合
      this.usedNumbers.clear();
    }

    let randomNumber: number;
    // do {
      randomNumber = Math.floor(Math.random() * (max - min + 1)) + min;
    // } while (this.usedNumbers.has(randomNumber));

    this.usedNumbers.add(randomNumber);
    return randomNumber;
  }
}
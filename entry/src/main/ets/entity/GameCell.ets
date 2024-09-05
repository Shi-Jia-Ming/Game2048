export class GameCell implements AnimatableArithmetic<number> {
  id: number;
  x: number;
  y: number;
  value: number;

  constructor(id: number, moveX: number, moveY: number, value: number) {
    this.id = id;
    this.x = moveX;
    this.y = moveY;
    this.value = value;
  }

  static generateCellList(xList: number[], yList: number[], valueList: number[]): GameCell[] {
    const cellList: GameCell[] = [];
    // TODO 长度校验
    xList.forEach((_: number, index: number) => {
      if (valueList[index] !== 0) {
        cellList.push(new GameCell(index, xList[index], yList[index], valueList[index]));
      }
    });
    return cellList;
  }

  plus(rhs: GameCell): GameCell {
    const result = new GameCell(this.id, this.x, this.y, this.value);
    result.x += rhs.x;
    result.y += rhs.y;
    return result;
  }

  subtract(rhs: GameCell): GameCell {
    const result = new GameCell(this.id, this.x, this.y, this.value);
    result.x -= rhs.x;
    result.y -= rhs.y;
    return result;
  }

  multiply(scale: number): GameCell {
    const result = new GameCell(this.id, this.x, this.y, this.value);
    result.x *= scale;
    result.y *= scale;
    return result;
  }

  equals(rhs: GameCell): boolean {
    return this.x === rhs.x && this.y === rhs.y;
  }
}

export class Move {
  id: number;
  moveX: number;
  moveY: number;
  action: Action;

  constructor(id: number, moveX: number, moveY: number, action: Action) {
    this.id = id;
    this.moveX = moveX;
    this.moveY = moveY;
    this.action = action;
  }

  static getMoveXList(moveList: Move[]): number[] {
    const moveXList: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    moveList.forEach((move: Move) => {
      if (move.id !== -1) {
        moveXList[move.id] += move.moveX;
      }
    });
    return moveXList;
  }

  static getMoveYList(moveList: Move[]): number[] {
    const moveYList: number[] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    moveList.forEach((move: Move) => {
      moveYList[move.id] += move.moveY;
    });
    return moveYList;
  }
}

export type Direction =
  | "left"
    | "right"
    | "up"
    | "down"
    | null


export type Action =
  | "disappear"
    | "double"
    | null


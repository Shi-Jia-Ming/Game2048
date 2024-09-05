export class Position {
  x: number = 0;
  y: number = 0;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }

  toString(): string {
    return "( " + this.x + ", " + this.y + " ) ";
  }

  equals(position: Position) {
    return position.x === this.x && position.y === this.y;
  }
}

export const allPosition: Position[] = [
  new Position(0 * 70, 0 * 70),
  new Position(0 * 70, 1 * 70),
  new Position(0 * 70, 2 * 70),
  new Position(0 * 70, 3 * 70),
  new Position(1 * 70, 0 * 70),
  new Position(1 * 70, 1 * 70),
  new Position(1 * 70, 2 * 70),
  new Position(1 * 70, 3 * 70),
  new Position(2 * 70, 0 * 70),
  new Position(2 * 70, 1 * 70),
  new Position(2 * 70, 2 * 70),
  new Position(2 * 70, 3 * 70),
  new Position(3 * 70, 0 * 70),
  new Position(3 * 70, 1 * 70),
  new Position(3 * 70, 2 * 70),
  new Position(3 * 70, 3 * 70),
]

export const allId: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
export const unusedId: number[] = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

export const generatePosition = (xList: number[], yList: number[]): Position => {
  const usedId: number[] = allId.filter((id: number) => {
    for (let i = 0; i < unusedId.length; i++) {
      if (unusedId[i] === id)  return false;
    }
    return true;
  });
  const usedPosition: Position[] = usedId.map((id: number) => {
      return new Position(xList[id], yList[id]);
  });
  const unusedPosition: Position[] = allPosition.filter((position: Position) => {
    for (let i = 0; i < usedPosition.length; i++) {
      if (usedPosition[i].equals(position)) return false;
    }
    return true;
  });
  let random = Math.floor(Math.random() * (unusedPosition.length - 1));
  return unusedPosition.splice(random, 1)[0];
}

export const generateId = (): number => {
  return unusedId.shift()!;
}

export const generateValue = (): number => {
  let random: number = Math.floor(Math.random() * 10);
  console.info(random.toString());
  return random > 8 ? 4 : 2;
}
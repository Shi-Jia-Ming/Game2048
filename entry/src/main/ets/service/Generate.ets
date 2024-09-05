export class Position {
  x: number = 0;
  y: number = 0;

  constructor(x: number, y: number) {
    this.x = x;
    this.y = y;
  }
}

export const unusedPosition = [
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
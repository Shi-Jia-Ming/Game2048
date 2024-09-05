import { type Direction, GameCell, Move } from '../entity/GameCell';

export function move(cellList: GameCell[], direction: Direction): Move[] {
  switch (direction) {
    case 'left': return moveLeft(cellList);
    case 'right': return moveRight(cellList);
    case 'up': return moveUp(cellList);
    case 'down': return moveDown(cellList);
    default: return [];
  }
}

function moveLeft(cellList: GameCell[]) {
  const chess: GameCell[][] =
    [[new GameCell(-1, 0, 0, 0), new GameCell(0, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)]];

  const moveList: Move[] = [];

  cellList.forEach((cell: GameCell) => {
    chess[cell.y / 70][cell.x / 70] = new GameCell(cell.id, cell.x, cell.y, cell.value);
  });

  chess.forEach((row: GameCell[]) => {
    let nextX: number = -1;
    for (let i = 0; i < 4; ++i) {
      nextX = -1;
      for (let m = i + 1; m < 4; ++m) {
        if (row[m].value !== 0) {
          nextX = m;
          break;
        }
      }

      if (nextX !== -1) {
        const distance: number = (nextX - i) * 70;
        if (row[i].value === 0) {
          // 将 nextX 位置的元素移动到 i 的位置
          row[nextX].x -= distance;
          moveList.push(new Move(row[nextX].id, -distance, 0, null));
          const tmpCell: GameCell = row[i];
          row[i] = row[nextX];
          row[nextX] = tmpCell;
          i--;
        } else if (row[i].value === row[nextX].value) {
          moveList.push(new Move(row[nextX].id, -distance, 0, 'disappear'));
          moveList.push(new Move(row[i].id, 0, 0, 'double'));
          row[nextX] = new GameCell(-1, 0, 0, 0);
        }
      }
    }
  });
  // 模拟移动
  return moveList;
}

function moveRight(cellList: GameCell[]) {
  const chess: GameCell[][] =
    [[new GameCell(-1, 0, 0, 0), new GameCell(0, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)]];

  const moveList: Move[] = [];

  cellList.forEach((cell: GameCell) => {
    chess[cell.y / 70][cell.x / 70] = new GameCell(cell.id, cell.x, cell.y, cell.value);
  });

  chess.forEach((row: GameCell[]) => {
    let nextX: number = -1;
    for (let i = 3; i >= 0; --i) {
      nextX = -1;
      for (let m = i - 1; m >= 0; --m) {
        if (row[m].value !== 0) {
          nextX = m;
          break;
        }
      }

      if (nextX !== -1) {
        const distance: number = (nextX - i) * 70;
        if (row[i].value === 0) {
          // 将 nextX 位置的元素移动到 i 的位置
          row[nextX].x -= distance;
          moveList.push(new Move(row[nextX].id, -distance, 0, null));
          const tmpCell: GameCell = row[i];
          row[i] = row[nextX];
          row[nextX] = tmpCell;
          i++;
        } else if (row[i].value === row[nextX].value) {
          moveList.push(new Move(row[nextX].id, -distance, 0, 'disappear'));
          moveList.push(new Move(row[i].id, 0, 0, 'double'));
          row[nextX] = new GameCell(-1, 0, 0, 0);
        }
      }
    }
  });
  // 模拟移动
  return moveList;
}

function moveUp(cellList: GameCell[]) {
  const chess: GameCell[][] =
    [[new GameCell(-1, 0, 0, 0), new GameCell(0, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)]];

  const moveList: Move[] = [];

  cellList.forEach((cell: GameCell) => {
    chess[cell.x / 70][cell.y / 70] = new GameCell(cell.id, cell.x, cell.y, cell.value);
  });

  chess.forEach((row: GameCell[]) => {
    let nextX: number = -1;
    for (let i = 0; i < 4; ++i) {
      nextX = -1;
      for (let m = i + 1; m < 4; ++m) {
        if (row[m].value !== 0) {
          nextX = m;
          break;
        }
      }

      if (nextX !== -1) {
        const distance: number = (nextX - i) * 70;
        if (row[i].value === 0) {
          // 将 nextX 位置的元素移动到 i 的位置
          row[nextX].x -= distance;
          moveList.push(new Move(row[nextX].id, 0, -distance, null));
          const tmpCell: GameCell = row[i];
          row[i] = row[nextX];
          row[nextX] = tmpCell;
          i--;
        } else if (row[i].value === row[nextX].value) {
          moveList.push(new Move(row[nextX].id,0, -distance, 'disappear'));
          moveList.push(new Move(row[i].id, 0, 0, 'double'));
          row[nextX] = new GameCell(-1, 0, 0, 0);
        }
      }
    }
  });
  // 模拟移动
  return moveList;
}

function moveDown(cellList: GameCell[]) {
  const chess: GameCell[][] =
    [[new GameCell(-1, 0, 0, 0), new GameCell(0, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)],
      [new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0), new GameCell(-1, 0, 0, 0)]];

  const moveList: Move[] = [];

  cellList.forEach((cell: GameCell) => {
    chess[cell.x / 70][cell.y / 70] = new GameCell(cell.id, cell.x, cell.y, cell.value);
  });

  chess.forEach((row: GameCell[]) => {
    let nextX: number = -1;
    for (let i = 3; i >= 0; --i) {
      nextX = -1;
      for (let m = i - 1; m >= 0; --m) {
        if (row[m].value !== 0) {
          nextX = m;
          break;
        }
      }

      if (nextX !== -1) {
        const distance: number = (nextX - i) * 70;
        if (row[i].value === 0) {
          // 将 nextX 位置的元素移动到 i 的位置
          row[nextX].x -= distance;
          moveList.push(new Move(row[nextX].id,0 , -distance, null));
          const tmpCell: GameCell = row[i];
          row[i] = row[nextX];
          row[nextX] = tmpCell;
          i++;
        } else if (row[i].value === row[nextX].value) {
          moveList.push(new Move(row[nextX].id,0 , -distance, 'disappear'));
          moveList.push(new Move(row[i].id, 0, 0, 'double'));
          row[nextX] = new GameCell(-1, 0, 0, 0);
        }
      }
    }
  });
  // 模拟移动
  return moveList;
}

/**
 * 0 -> 0 * 0
 * 1 -> 1 * 0
 * 2 -> 2 * 0
 * 3 -> 3 * 0
 * 4 -> 1 * 1
 */
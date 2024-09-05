import { colorList } from '../entity/ColorList';
import { GameCell, Move } from '../entity/GameCell';
import { move } from '../service/Move';
import { UniqueRandomGenerator } from '../utils/RandomGenerator';
import { Board } from '../component/Board';

@AnimatableExtend(Text)
function animatableLocation(move: GameCell) {
  .position({ x: move.x, y: move.y })
}

@Entry
@Component
struct Index {
  @State board: number[][] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];
  @State xList: number[] = [140, 70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  @State yList: number[] = [70, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  @State valueList: number[] = [2, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  @State existingId: number[] = [0, 1];
  @State unusedId: number[] = [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];
  @State nextIdQueue: number[] = [this.existingId.length];
  @State nextX: number = -1;
  @State nextY: number = -1;

  // 不存在元素的坐标
  @State unusedPosition: number = 0;

  aboutToAppear(): void {
  }

  generateRandom(max: number, exclude: number[]): number {
    let randomNum = Math.floor(Math.random() * max);
    while (exclude.includes(randomNum)) {
      randomNum = new UniqueRandomGenerator().getRandomInt(0, max - 1);
      console.log('generate');
    }
    return randomNum;
  }

  generateRandomPosition(): number[] {
    const generator = new UniqueRandomGenerator();
    while (true) {
      let randomX: number = generator.getRandomInt(0, 3);
      let randomY: number = generator.getRandomInt(0, 3);
      for (let i = 0; i < 16; ++i) {
        if (this.xList[i] / 70 === randomX && this.yList[i] / 70 === randomY) {
          break;
        } else if (i === 15) {
          return [randomX, randomY];
        }
      }
    }
  }

  @Builder
  Cell(index: number) {
    if (this.valueList[index] !== 0) {
      Text(this.valueList[index].toString())
        .width(60)
        .height(60)
        .fontColor(Color.White)
        .fontWeight(FontWeight.Bold)
        .fontSize(24)
        .textAlign(TextAlign.Center)
        .backgroundColor(colorList[Math.log(this.valueList[index]) / Math.log(2)])
        .animatableLocation(new GameCell(index, this.xList[index], this.yList[index], this.valueList[index]))
        .animation({ duration: 200, curve: Curve.Friction })
        .transition(TransitionEffect.OPACITY
          .combine(TransitionEffect.scale({ x: 0.5, y: 0.5 }))
            // 对每个方格的转场添加delay，实现组件的渐次出现消失效果
          .animation({ duration: 200, curve: Curve.Friction, delay: 100 }))
    }
  }

  build() {
    RelativeContainer() {
      Text('Game 2048')
        .fontSize(40)
        .fontWeight(FontWeight.Bolder)
        .margin({top: 20})
        .alignRules({
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Board()
        .id('__background__')
      // TODO id: __board__
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })

      Column() {
        this.Cell(0)
        this.Cell(1)
        this.Cell(2)
        this.Cell(3)
        this.Cell(4)
        this.Cell(5)
        this.Cell(6)
        this.Cell(7)
        this.Cell(8)
        this.Cell(9)
        this.Cell(10)
        this.Cell(11)
        this.Cell(12)
        this.Cell(13)
        this.Cell(14)
        this.Cell(15)
      }
      .id("__board__")
      .height(300)
      .width(300)
      .padding(15)
      .alignRules({
        top: { anchor: '__background__', align: VerticalAlign.Top },
        left: { anchor: '__background__', align: HorizontalAlign.Start }
      })
      .justifyContent(FlexAlign.Start)
      .alignItems(HorizontalAlign.Start)
    }
    .height('100%')
    .width('100%')
    .backgroundColor('#faf8ef')
    .padding({top: 20, bottom: 20})
    .onKeyEvent((event?: KeyEvent) => {
      if (event && event.type === KeyType.Down) {
        const cellList: GameCell[] = GameCell.generateCellList(this.xList, this.yList, this.valueList);
        let moveList: Move[];
        switch (event.keyCode) {
          case 2012: {
            // Up
            moveList = move(cellList, 'up');
            break;
          } case 2013: {
            //Down
            moveList = move(cellList, 'down');
            break;
          } case 2014: {
            // Left
            moveList = move(cellList, 'left');
            break;
          } case 2015: {
            // Right
            moveList = move(cellList, 'right');
            break;
          } default : moveList = [];
        }

        if (moveList.length !== 0) {
          const moveXList: number[] = Move.getMoveXList(moveList);
          const moveYList: number[] = Move.getMoveYList(moveList);

          this.xList.forEach((_: number, index: number) => {
            this.xList[index] += moveXList[index];
            this.yList[index] += moveYList[index];
          });

          setTimeout(() => {
            moveList.forEach((move: Move) => {
              switch (move.action) {
                case 'disappear':
                  this.valueList[move.id] = 0;
                  setTimeout(() => {
                    this.xList[move.id] = 0;
                    this.yList[move.id] = 0;
                  }, 1000);
                  this.existingId.splice(this.existingId.indexOf(move.id), 1);
                  this.unusedId.push(move.id);
                  break;
                case 'double':
                  this.valueList[move.id] *= 2;
                  break;
              }
            });
          }, 100);

          setTimeout(() => {
            if (this.unusedId.length === 0) {
              console.log('Game Over');
              return;
            }

            const generatedValue: number = this.generateRandom(10, []) > 7 ? 4 : 2;
            const position: number[] = this.generateRandomPosition();
            const generatedX: number = position[0] * 70;
            const generatedY: number = position[1] * 70;
            // TODO 如果没有可以用的则游戏结束？
            const generatedId: number = this.unusedId.shift()!;
            console.log('id: ', generatedId, 'value: ', generatedValue, ' position: ', position.toString());

            this.xList[generatedId] = generatedX;
            this.yList[generatedId] = generatedY;
            this.valueList[generatedId] = generatedValue;

            this.existingId.push(generatedId);

            console.log('existing', this.existingId);
            console.log('unused', this.unusedId);
          }, 200);
        }
      }
    })
    .gesture(
      PanGesture({ direction: PanDirection.All })
        .onActionStart((event: GestureEvent | undefined) => {
          if (event) {
            const cellList: GameCell[] = GameCell.generateCellList(this.xList, this.yList, this.valueList);
            let moveList: Move[];
            if (event.offsetY > 0 && Math.abs(event.offsetY) > Math.abs(event.offsetX)) {
              moveList = move(cellList, 'down');
            } else if (event.offsetY < 0 && Math.abs(event.offsetY) > Math.abs(event.offsetX)) {
              moveList = move(cellList, 'up');
            } else if (event.offsetX > 0) {
              moveList = move(cellList, 'right');
            } else {
              moveList = move(cellList, 'left');
            }
            const moveXList: number[] = Move.getMoveXList(moveList);
            const moveYList: number[] = Move.getMoveYList(moveList);

            if (moveList.length !== 0) {
              this.xList.forEach((_: number, index: number) => {
                this.xList[index] += moveXList[index];
                this.yList[index] += moveYList[index];
              });

              setTimeout(() => {
                moveList.forEach((move: Move) => {
                  switch (move.action) {
                    case 'disappear':
                      this.valueList[move.id] = 0;
                      setTimeout(() => {
                        this.xList[move.id] = 0;
                        this.yList[move.id] = 0;
                      }, 1000);
                      this.existingId.splice(this.existingId.indexOf(move.id), 1);
                      this.unusedId.push(move.id);
                      break;
                    case 'double':
                      this.valueList[move.id] *= 2;
                      break;
                  }
                });
              }, 100);

              setTimeout(() => {
                if (this.unusedId.length === 0) {
                  console.log('Game Over');
                  return;
                }

                const generatedValue: number = this.generateRandom(10, []) > 7 ? 4 : 2;
                const position: number[] = this.generateRandomPosition();
                const generatedX: number = position[0] * 70;
                const generatedY: number = position[1] * 70;
                // TODO 如果没有可以用的则游戏结束？
                const generatedId: number = this.unusedId.shift()!;
                console.log('id: ', generatedId, 'value: ', generatedValue, ' position: ', position.toString());

                this.xList[generatedId] = generatedX;
                this.yList[generatedId] = generatedY;
                this.valueList[generatedId] = generatedValue;

                this.existingId.push(generatedId);

                console.log('existing', this.existingId);
                console.log('unused', this.unusedId);
              }, 200);
            }
          }
        })
    )
  }
}
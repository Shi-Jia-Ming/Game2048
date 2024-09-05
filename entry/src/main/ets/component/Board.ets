@Component
export struct Board {

  @State board: number[][] = [[0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0], [0, 0, 0, 0]];

  @Prop boardColor: string = '#cdc1b4';
  @Prop boardWidth: number = 300;
  @Prop boardHeight: number = 300;
  @Prop boardGap: number = 10;
  @Prop boardBorderWidth: number = 5;

  build() {
    Grid() {
      ForEach(this.board, (row: number[]) => {
        ForEach(row, (_: number) => {
          GridItem()
            .backgroundColor(this.boardColor)
        })
      })
    }
    .id('__background__')
    .width(this.boardWidth)
    .height(this.boardHeight)
    .rowsTemplate('1fr 1fr 1fr 1fr')
    .columnsTemplate('1fr 1fr 1fr 1fr')
    .columnsGap(this.boardGap)
    .rowsGap(this.boardGap)
    .padding(this.boardGap)
    .borderWidth(this.boardBorderWidth)
  }
}
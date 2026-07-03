import { Density, Token } from '../theme/Tokens';

/**
 * 轮播容器：封装系统 Swiper，指示点按 Token 主题化。
 * 每页内容放入 pages 插槽（多个直接子组件按页轮播）。
 */
@Component
export struct AppSwiper {
  @Prop autoPlay: boolean = false;
  @Prop interval: number = 3000;
  @Prop loop: boolean = true;
  @StorageLink('isDark') isDark: boolean = false;
  @StorageLink('brand') brand: string = 'default';
  @StorageProp('density') density: Density = Density.Comfortable;
  @BuilderParam pages: () => void;

  build() {
    Swiper() {
      this.pages()
    }
    .autoPlay(this.autoPlay)
    .interval(this.interval)
    .loop(this.loop)
    .itemSpace(Token.space.sm)
    .indicator(
      Indicator.dot()
        .color(Token.color.outline())
        .selectedColor(Token.color.primary(this.brand))
    )
    .curve(Token.motion.easeStandard)
    .duration(Token.motion.normal)
    .borderRadius(Token.radius.lg)
  }
}

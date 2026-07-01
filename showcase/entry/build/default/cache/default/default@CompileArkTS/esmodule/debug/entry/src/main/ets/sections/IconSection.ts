if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface IconSection_Params {
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
interface IconItem {
    name: string;
    size: number;
}
export class IconSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: IconSection_Params) {
    }
    updateStateVars(params: IconSection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private items(): IconItem[] {
        const i = Token.icon;
        return [
            { name: 'xs', size: i.xs }, { name: 'sm', size: i.sm },
            { name: 'md', size: i.md }, { name: 'lg', size: i.lg },
            { name: 'xl', size: i.xl }, { name: 'xxl', size: i.xxl },
        ];
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.margin({ bottom: Token.space.lg });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SectionLabel(this, { text: 'Icon · 图标尺寸' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/IconSection.ets", line: 21, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Icon · 图标尺寸'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Icon · 图标尺寸'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({ wrap: FlexWrap.Wrap, alignItems: ItemAlign.End });
            Flex.width('100%');
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.justifyContent(FlexAlign.End);
                    Column.alignItems(HorizontalAlign.Center);
                    Column.width(64);
                    Column.margin({ right: Token.space.sm, bottom: Token.space.sm });
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    // 用一个圆形代替图标，演示尺寸网格与命中区概念
                    Circle.create({ width: item.size, height: item.size });
                    // 用一个圆形代替图标，演示尺寸网格与命中区概念
                    Circle.fill(Token.color.primary());
                }, Circle);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(`${item.name} · ${item.size}`);
                    Text.fontSize(Token.font.caption.size);
                    Text.fontColor(Token.color.onSurfaceVariant());
                    Text.margin({ top: Token.space.xxs });
                }, Text);
                Text.pop();
                Column.pop();
            };
            this.forEachUpdateFunction(elmtId, this.items(), forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        Flex.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('默认 24vp；命中区始终 ≥ 44×44vp（见 Accessibility）。');
            Text.fontSize(Token.font.caption.size);
            Text.fontColor(Token.color.onSurfaceVariant());
        }, Text);
        Text.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

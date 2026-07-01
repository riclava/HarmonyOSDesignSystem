if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface ColorSection_Params {
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
interface Swatch {
    name: string;
    color: ResourceColor;
    onColor: ResourceColor;
}
export class ColorSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: ColorSection_Params) {
    }
    updateStateVars(params: ColorSection_Params) {
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
    private swatches(): Swatch[] {
        const onLight = Token.color.onPrimary();
        const onDark = Token.color.onSurface();
        return [
            { name: 'Primary', color: Token.color.primary(), onColor: onLight },
            { name: 'PrimaryContainer', color: Token.color.primaryContainer(), onColor: Token.color.onSurface() },
            { name: 'Secondary', color: Token.color.secondary(), onColor: onLight },
            { name: 'Success', color: Token.color.success(), onColor: onLight },
            { name: 'Warning', color: Token.color.warning(), onColor: onLight },
            { name: 'Danger', color: Token.color.danger(), onColor: onLight },
            { name: 'Info', color: Token.color.info(), onColor: onLight },
            { name: 'Surface', color: Token.color.surface(), onColor: onDark },
            { name: 'Background', color: Token.color.background(), onColor: onDark },
            { name: 'Outline', color: Token.color.outline(), onColor: onDark },
            { name: 'Divider', color: Token.color.divider(), onColor: onDark },
            { name: 'OnSurfaceVariant', color: Token.color.onSurfaceVariant(), onColor: onLight },
        ];
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.width('100%');
            Column.margin({ bottom: Token.space.lg });
        }, Column);
        {
            this.observeComponentCreation2((elmtId, isInitialRender) => {
                if (isInitialRender) {
                    let componentCall = new SectionLabel(this, { text: 'Color · 颜色 Token' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/ColorSection.ets", line: 31, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Color · 颜色 Token'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Color · 颜色 Token'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Grid.create();
            Grid.columnsTemplate('1fr 1fr');
            Grid.columnsGap(Token.space.xs);
            Grid.rowsGap(Token.space.xs);
            Grid.width('100%');
        }, Grid);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const s = _item;
                {
                    const itemCreation2 = (elmtId, isInitialRender) => {
                        GridItem.create(() => { }, false);
                    };
                    const observedDeepRender = () => {
                        this.observeComponentCreation2(itemCreation2, GridItem);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Column.create();
                            Column.justifyContent(FlexAlign.End);
                            Column.alignItems(HorizontalAlign.Start);
                            Column.width('100%');
                            Column.height(72);
                            Column.padding(Token.space.xs);
                            Column.backgroundColor(s.color);
                            Column.borderRadius(Token.radius.sm);
                            Column.border({ width: 1, color: Token.color.outline() });
                        }, Column);
                        this.observeComponentCreation2((elmtId, isInitialRender) => {
                            Text.create(s.name);
                            Text.fontSize(Token.font.caption.size);
                            Text.fontColor(s.onColor);
                        }, Text);
                        Text.pop();
                        Column.pop();
                        GridItem.pop();
                    };
                    observedDeepRender();
                }
            };
            this.forEachUpdateFunction(elmtId, this.swatches(), forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        Grid.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

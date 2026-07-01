if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface TypographySection_Params {
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
interface TypeItem {
    name: string;
    size: number;
    lineHeight: number;
    weight: number;
}
export class TypographySection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: TypographySection_Params) {
    }
    updateStateVars(params: TypographySection_Params) {
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
    private items(): TypeItem[] {
        const f = Token.font;
        return [
            { name: 'DisplayLarge', size: f.displayLarge.size, lineHeight: f.displayLarge.lineHeight, weight: f.displayLarge.weight },
            { name: 'HeadlineLarge', size: f.headlineLarge.size, lineHeight: f.headlineLarge.lineHeight, weight: f.headlineLarge.weight },
            { name: 'HeadlineMedium', size: f.headlineMedium.size, lineHeight: f.headlineMedium.lineHeight, weight: f.headlineMedium.weight },
            { name: 'TitleLarge', size: f.titleLarge.size, lineHeight: f.titleLarge.lineHeight, weight: f.titleLarge.weight },
            { name: 'Body', size: f.body.size, lineHeight: f.body.lineHeight, weight: f.body.weight },
            { name: 'Label', size: f.label.size, lineHeight: f.label.lineHeight, weight: f.label.weight },
            { name: 'Caption', size: f.caption.size, lineHeight: f.caption.lineHeight, weight: f.caption.weight },
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
                    let componentCall = new SectionLabel(this, { text: 'Typography · 字体' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/TypographySection.ets", line: 25, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Typography · 字体'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Typography · 字体'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const t = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.alignItems(HorizontalAlign.Start);
                    Column.width('100%');
                    Column.padding({ top: Token.space.xs, bottom: Token.space.xs });
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(t.name);
                    Text.fontSize(t.size);
                    Text.lineHeight(t.lineHeight);
                    Text.fontWeight(t.weight);
                    Text.fontColor(Token.color.onSurface());
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(`${t.size}fp · line ${t.lineHeight} · weight ${t.weight}`);
                    Text.fontSize(Token.font.caption.size);
                    Text.fontColor(Token.color.onSurfaceVariant());
                }, Text);
                Text.pop();
                Column.pop();
            };
            this.forEachUpdateFunction(elmtId, this.items(), forEachItemGenFunction);
        }, ForEach);
        ForEach.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

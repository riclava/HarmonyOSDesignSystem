if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface RadiusSection_Params {
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
interface RadiusItem {
    name: string;
    value: number;
}
export class RadiusSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: RadiusSection_Params) {
    }
    updateStateVars(params: RadiusSection_Params) {
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
    private items(): RadiusItem[] {
        const r = Token.radius;
        return [
            { name: 'xs', value: r.xs }, { name: 'sm', value: r.sm },
            { name: 'md', value: r.md }, { name: 'lg', value: r.lg },
            { name: 'xl', value: r.xl }, { name: 'full', value: r.full },
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
                    let componentCall = new SectionLabel(this, { text: 'Radius · 圆角' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/RadiusSection.ets", line: 21, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Radius · 圆角'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Radius · 圆角'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Flex.create({ wrap: FlexWrap.Wrap });
            Flex.width('100%');
        }, Flex);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.margin({ right: Token.space.md, bottom: Token.space.sm });
                }, Column);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Column.create();
                    Column.width(56);
                    Column.height(56);
                    Column.backgroundColor(Token.color.primaryContainer());
                    Column.borderRadius(item.value === Token.radius.full ? 28 : item.value);
                    Column.border({ width: 1, color: Token.color.primary() });
                }, Column);
                Column.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(item.name);
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
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

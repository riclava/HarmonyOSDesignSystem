if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface SpacingSection_Params {
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
interface SpaceItem {
    name: string;
    value: number;
}
export class SpacingSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: SpacingSection_Params) {
    }
    updateStateVars(params: SpacingSection_Params) {
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
    private items(): SpaceItem[] {
        const s = Token.space;
        return [
            { name: 'xxs', value: s.xxs }, { name: 'xs', value: s.xs },
            { name: 'sm', value: s.sm }, { name: 'md', value: s.md },
            { name: 'lg', value: s.lg }, { name: 'xl', value: s.xl },
            { name: 'xxl', value: s.xxl }, { name: '3xl', value: s.xxxl },
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
                    let componentCall = new SectionLabel(this, { text: 'Spacing · 间距（8pt Grid）' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/SpacingSection.ets", line: 22, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Spacing · 间距（8pt Grid）'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Spacing · 间距（8pt Grid）'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            ForEach.create();
            const forEachItemGenFunction = _item => {
                const item = _item;
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.width('100%');
                    Row.padding({ top: Token.space.xxs, bottom: Token.space.xxs });
                }, Row);
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(`Space.${item.name}`);
                    Text.fontSize(Token.font.bodySmall.size);
                    Text.fontColor(Token.color.onSurface());
                    Text.width(110);
                }, Text);
                Text.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Row.create();
                    Row.width(item.value);
                    Row.height(16);
                    Row.backgroundColor(Token.color.primary());
                    Row.borderRadius(Token.radius.xs);
                }, Row);
                Row.pop();
                this.observeComponentCreation2((elmtId, isInitialRender) => {
                    Text.create(`${item.value}vp`);
                    Text.fontSize(Token.font.caption.size);
                    Text.fontColor(Token.color.onSurfaceVariant());
                    Text.margin({ left: Token.space.xs });
                }, Text);
                Text.pop();
                Row.pop();
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

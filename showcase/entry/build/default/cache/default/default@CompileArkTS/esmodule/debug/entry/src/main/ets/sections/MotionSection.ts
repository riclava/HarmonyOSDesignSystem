if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface MotionSection_Params {
    isDark?: boolean;
    moved?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
import { SectionLabel } from "@bundle:com.riclava.dsshowcase/entry/ets/sections/Widgets";
export class MotionSection extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.__moved = new ObservedPropertySimplePU(false, this, "moved");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: MotionSection_Params) {
        if (params.moved !== undefined) {
            this.moved = params.moved;
        }
    }
    updateStateVars(params: MotionSection_Params) {
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
        this.__moved.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__isDark.aboutToBeDeleted();
        this.__moved.aboutToBeDeleted();
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
    private __moved: ObservedPropertySimplePU<boolean>;
    get moved() {
        return this.__moved.get();
    }
    set moved(newValue: boolean) {
        this.__moved.set(newValue);
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
                    let componentCall = new SectionLabel(this, { text: 'Motion · 动画（点击方块演示）' }, undefined, elmtId, () => { }, { page: "entry/src/main/ets/sections/MotionSection.ets", line: 11, col: 7 });
                    ViewPU.create(componentCall);
                    let paramsLambda = () => {
                        return {
                            text: 'Motion · 动画（点击方块演示）'
                        };
                    };
                    componentCall.paramsGenerator_ = paramsLambda;
                }
                else {
                    this.updateStateVarsOfChildByElmtId(elmtId, {
                        text: 'Motion · 动画（点击方块演示）'
                    });
                }
            }, { name: "SectionLabel" });
        }
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Column.alignItems(HorizontalAlign.Start);
            Column.width('100%');
            Column.padding(Token.space.md);
            Column.backgroundColor(Token.color.surface());
            Column.borderRadius(Token.radius.md);
            Column.onClick(() => { this.moved = !this.moved; });
        }, Column);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Row.width('100%');
            Row.height(56);
        }, Row);
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Column.create();
            Context.animation({
                duration: Token.motion.normal,
                curve: this.moved ? Token.motion.easeOut : Token.motion.easeIn
            });
            Column.width(40);
            Column.height(40);
            Column.backgroundColor(Token.color.primary());
            Column.borderRadius(Token.radius.sm);
            Column.translate({ x: this.moved ? 200 : 0 });
            Context.animation(null);
        }, Column);
        Column.pop();
        Row.pop();
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Text.create('Instant 100 · Fast 200 · Normal 250 · Slow 300 · ExtraSlow 400');
            Text.fontSize(Token.font.caption.size);
            Text.fontColor(Token.color.onSurfaceVariant());
        }, Text);
        Text.pop();
        Column.pop();
        Column.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

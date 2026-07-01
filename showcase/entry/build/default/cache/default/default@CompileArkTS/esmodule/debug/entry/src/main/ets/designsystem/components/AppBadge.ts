if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface AppBadge_Params {
    count?: number;
    dot?: boolean;
    isDark?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export class AppBadge extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__count = new SynchedPropertySimpleOneWayPU(params.count, this, "count");
        this.__dot = new SynchedPropertySimpleOneWayPU(params.dot, this, "dot");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: AppBadge_Params) {
        if (params.count === undefined) {
            this.__count.set(0);
        }
        if (params.dot === undefined) {
            this.__dot.set(false);
        }
    }
    updateStateVars(params: AppBadge_Params) {
        this.__count.reset(params.count);
        this.__dot.reset(params.dot);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__count.purgeDependencyOnElmtId(rmElmtId);
        this.__dot.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__count.aboutToBeDeleted();
        this.__dot.aboutToBeDeleted();
        this.__isDark.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __count: SynchedPropertySimpleOneWayPU<number>;
    get count() {
        return this.__count.get();
    }
    set count(newValue: number) {
        this.__count.set(newValue);
    }
    private __dot: SynchedPropertySimpleOneWayPU<boolean>;
    get dot() {
        return this.__dot.get();
    }
    set dot(newValue: boolean) {
        this.__dot.set(newValue);
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private label(): string {
        return this.count > 99 ? '99+' : `${this.count}`;
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            If.create();
            if (this.dot) {
                this.ifElseBranchUpdateFunction(0, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Circle.create({ width: 8, height: 8 });
                        Circle.fill(Token.color.danger());
                    }, Circle);
                });
            }
            else {
                this.ifElseBranchUpdateFunction(1, () => {
                    this.observeComponentCreation2((elmtId, isInitialRender) => {
                        Text.create(this.label());
                        Text.fontSize(Token.font.caption.size);
                        Text.fontColor(Token.color.onPrimary());
                        Text.height(16);
                        Text.constraintSize({ minWidth: 16 });
                        Text.padding({ left: Token.space.xxs, right: Token.space.xxs });
                        Text.backgroundColor(Token.color.danger());
                        Text.borderRadius(Token.radius.full);
                        Text.textAlign(TextAlign.Center);
                    }, Text);
                    Text.pop();
                });
            }
        }, If);
        If.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

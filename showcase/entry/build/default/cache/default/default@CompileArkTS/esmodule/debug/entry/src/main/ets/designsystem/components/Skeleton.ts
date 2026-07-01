if (!("finalizeConstruction" in ViewPU.prototype)) {
    Reflect.set(ViewPU.prototype, "finalizeConstruction", () => { });
}
interface Skeleton_Params {
    blockWidth?: Length;
    blockHeight?: Length;
    radius?: number;
    isDark?: boolean;
    shimmer?: boolean;
}
import { Token } from "@bundle:com.riclava.dsshowcase/entry/ets/designsystem/Tokens";
export class Skeleton extends ViewPU {
    constructor(parent, params, __localStorage, elmtId = -1, paramsLambda = undefined, extraInfo) {
        super(parent, __localStorage, elmtId, extraInfo);
        if (typeof paramsLambda === "function") {
            this.paramsGenerator_ = paramsLambda;
        }
        this.__blockWidth = new SynchedPropertyObjectOneWayPU(params.blockWidth, this, "blockWidth");
        this.__blockHeight = new SynchedPropertyObjectOneWayPU(params.blockHeight, this, "blockHeight");
        this.__radius = new SynchedPropertySimpleOneWayPU(params.radius, this, "radius");
        this.__isDark = this.createStorageLink('isDark', false, "isDark");
        this.__shimmer = new ObservedPropertySimplePU(false, this, "shimmer");
        this.setInitiallyProvidedValue(params);
        this.finalizeConstruction();
    }
    setInitiallyProvidedValue(params: Skeleton_Params) {
        if (params.blockWidth === undefined) {
            this.__blockWidth.set('100%');
        }
        if (params.blockHeight === undefined) {
            this.__blockHeight.set(16);
        }
        if (params.radius === undefined) {
            this.__radius.set(Token.radius.xs);
        }
        if (params.shimmer !== undefined) {
            this.shimmer = params.shimmer;
        }
    }
    updateStateVars(params: Skeleton_Params) {
        this.__blockWidth.reset(params.blockWidth);
        this.__blockHeight.reset(params.blockHeight);
        this.__radius.reset(params.radius);
    }
    purgeVariableDependenciesOnElmtId(rmElmtId) {
        this.__blockWidth.purgeDependencyOnElmtId(rmElmtId);
        this.__blockHeight.purgeDependencyOnElmtId(rmElmtId);
        this.__radius.purgeDependencyOnElmtId(rmElmtId);
        this.__isDark.purgeDependencyOnElmtId(rmElmtId);
        this.__shimmer.purgeDependencyOnElmtId(rmElmtId);
    }
    aboutToBeDeleted() {
        this.__blockWidth.aboutToBeDeleted();
        this.__blockHeight.aboutToBeDeleted();
        this.__radius.aboutToBeDeleted();
        this.__isDark.aboutToBeDeleted();
        this.__shimmer.aboutToBeDeleted();
        SubscriberManager.Get().delete(this.id__());
        this.aboutToBeDeletedInternal();
    }
    private __blockWidth: SynchedPropertySimpleOneWayPU<Length>;
    get blockWidth() {
        return this.__blockWidth.get();
    }
    set blockWidth(newValue: Length) {
        this.__blockWidth.set(newValue);
    }
    private __blockHeight: SynchedPropertySimpleOneWayPU<Length>;
    get blockHeight() {
        return this.__blockHeight.get();
    }
    set blockHeight(newValue: Length) {
        this.__blockHeight.set(newValue);
    }
    private __radius: SynchedPropertySimpleOneWayPU<number>;
    get radius() {
        return this.__radius.get();
    }
    set radius(newValue: number) {
        this.__radius.set(newValue);
    }
    private __isDark: ObservedPropertyAbstractPU<boolean>;
    get isDark() {
        return this.__isDark.get();
    }
    set isDark(newValue: boolean) {
        this.__isDark.set(newValue);
    }
    private __shimmer: ObservedPropertySimplePU<boolean>;
    get shimmer() {
        return this.__shimmer.get();
    }
    set shimmer(newValue: boolean) {
        this.__shimmer.set(newValue);
    }
    aboutToAppear(): void {
        // 循环闪烁：透明度在 0.4~1 之间往返
        this.shimmer = true;
    }
    initialRender() {
        this.observeComponentCreation2((elmtId, isInitialRender) => {
            Row.create();
            Context.animation({
                duration: Token.motion.extraSlow,
                curve: Token.motion.easeStandard,
                iterations: -1,
                playMode: PlayMode.Alternate
            });
            Row.width(ObservedObject.GetRawObject(this.blockWidth));
            Row.height(ObservedObject.GetRawObject(this.blockHeight));
            Row.backgroundColor(Token.color.divider());
            Row.borderRadius(this.radius);
            Row.opacity(this.shimmer ? 0.4 : 1);
            Context.animation(null);
        }, Row);
        Row.pop();
    }
    rerender() {
        this.updateDirtyElements();
    }
}

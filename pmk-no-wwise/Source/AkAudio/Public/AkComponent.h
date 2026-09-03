#pragma once

#include "CoreMinimal.h"
#include "Components/SceneComponent.h"
#include "AkComponent.generated.h"

/**
 * Пустая заглушка вместо Wwise-плагина.
 * Нужна только PalAkComponent.h кита (наследуется от UAkComponent)
 * и UPROPERTY-указателям этого типа в звуковых Pal-классах.
 */
UCLASS(ClassGroup = (Custom), Blueprintable, meta = (BlueprintSpawnableComponent))
class AKAUDIO_API UAkComponent : public USceneComponent
{
    GENERATED_BODY()
};

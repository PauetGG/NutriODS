import { Suspense, useRef, useMemo } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import { OrbitControls, useGLTF } from "@react-three/drei";
import { Mesh, Object3D } from "three";
// @ts-expect-error: no hay tipos para SkeletonUtils
import { clone } from "three/examples/jsm/utils/SkeletonUtils";


type AvatarViewerProps = {
  url: string;
  height?: number;
};

function AvatarModel({ url }: { url: string }) {
  const { scene } = useGLTF(url, true);

  // Clonamos el modelo completo (con esqueletos si los tiene)
  const clonedScene = useMemo(() => clone(scene) as Object3D, [scene]);

  // Referencia para rotación
  const modelRef = useRef<Mesh>(null!);
  clonedScene.position.y = -1;

  useFrame(() => {
    if (modelRef.current) {
      modelRef.current.rotation.y += 0.0025;
    }
  });

  return <primitive ref={modelRef} object={clonedScene} scale={1.8} />;
}

// Precarga segura del modelo para evitar glitches visuales
useGLTF.preload("/path/to/any.glb");

export const AvatarViewer = ({ url, height = 350 }: AvatarViewerProps) => {
  return (
    <div
      className="w-full"
      style={{
        height,
        maxHeight: height,
        overflow: "hidden",
      }}
    >
      <Canvas
        camera={{ position: [0, 1.5, 3.5] }}
        style={{
          height: "100%",
          width: "100%",
        }}
      >
        <ambientLight intensity={0.6} />
        <directionalLight position={[5, 10, 5]} intensity={1} />
        <Suspense fallback={null}>
          <AvatarModel url={url} />
        </Suspense>
        <OrbitControls enableZoom={false} />
      </Canvas>
    </div>
  );
};

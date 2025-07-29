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
  const clonedScene = useMemo(() => clone(scene) as Object3D, [scene]);

  const modelRef = useRef<Mesh>(null!);

  // Centrado y elevación del modelo
  clonedScene.position.set(0, -1.4, 0); // baja para que se vea la cabeza y pies
  clonedScene.rotation.y = Math.PI; // giro inicial para que mire al frente

  useFrame(() => {
    if (modelRef.current) {
      modelRef.current.rotation.y += 0.0025;
    }
  });

  return <primitive ref={modelRef} object={clonedScene} scale={1.6} />;
}

useGLTF.preload("/path/to/any.glb");

export const AvatarViewer = ({ url, height = 360 }: AvatarViewerProps) => {
  return (
    <div
      className="flex justify-center items-center"
      style={{
        height,
        width: "100%",
        padding: 0,
        margin: 0,
        overflow: "hidden",
        background: "transparent",
      }}
    >
      <Canvas
        camera={{ position: [0, 1.4, 2.5] }} // mejor ángulo y distancia
        style={{ height: "100%", width: "100%" }}
      >
        <ambientLight intensity={0.7} />
        <directionalLight position={[3, 10, 5]} intensity={1.2} />
        <Suspense fallback={null}>
          <AvatarModel url={url} />
        </Suspense>
        <OrbitControls enableZoom={false} enablePan={false} />
      </Canvas>
    </div>
  );
};

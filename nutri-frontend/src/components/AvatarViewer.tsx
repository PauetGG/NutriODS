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
  clonedScene.position.y = -0.5; // Subimos ligeramente para no cortar cabeza

  useFrame(() => {
    if (modelRef.current) {
      modelRef.current.rotation.y += 0.0025;
    }
  });

  return <primitive ref={modelRef} object={clonedScene} scale={1.8} />;
}

useGLTF.preload("/path/to/any.glb");

export const AvatarViewer = ({ url, height = 350 }: AvatarViewerProps) => {
  return (
    <div
      className="flex justify-center items-center"
      style={{
        height,
        padding: 0,
        margin: 0,
        overflow: "hidden",
        background: "transparent",
      }}
    >
      <Canvas
        camera={{ position: [0, 1.1, 3.2] }} // Ajustamos cámara más baja
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

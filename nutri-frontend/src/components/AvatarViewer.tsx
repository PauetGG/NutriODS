import { Suspense, useRef } from "react";
import { Canvas, useFrame } from "@react-three/fiber";
import { OrbitControls, useGLTF } from "@react-three/drei";
import { Mesh } from "three";

type AvatarViewerProps = {
  url: string;
};

function AvatarModel({ url }: { url: string }) {
  const { scene } = useGLTF(url);
  const modelRef = useRef<Mesh>(null!);

  useFrame(() => {
    if (modelRef.current) {
      modelRef.current.rotation.y += 0.0025; // rotación lenta para que no moleste
    }
  });

  return <primitive ref={modelRef} object={scene} scale={1.2} />;
}

export const AvatarViewer = ({ url }: AvatarViewerProps) => {
  return (
    <div className="w-full h-[500px]">
      <Canvas camera={{ position: [0, 1.5, 3.5] }}>
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

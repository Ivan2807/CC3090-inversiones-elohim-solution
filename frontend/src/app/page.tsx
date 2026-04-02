import Image from "next/image";
import styles from "./page.module.css";

export default function Home() {
  return (
    <main>
      <h1>Hola, este mensaje vive gracias a Next.js 16</h1>
      <img src="https://static.wikia.nocookie.net/simpsons/images/c/ce/Kingsizehomer.jpg/revision/latest?cb=20100226052645" alt="homero trabajon para el proyecto de ingenieria de software" />
    </main>
  );
}

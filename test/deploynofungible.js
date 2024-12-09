const hre = require("hardhat");

async function main() {
  // Obtén la cuenta del administrador (primer signer)
  const [admin] = await hre.ethers.getSigners();

  // Despliega el contrato "ProjectStages"
  const ProjectStages = await hre.ethers.getContractFactory("ProjectStages");
  const projectStages = await ProjectStages.deploy();

  // Espera a que el contrato sea desplegado
  await projectStages.waitForDeployment();

  // Obtén la dirección del contrato desplegado
  const contractAddress = await projectStages.getAddress();
  console.log("ProjectStages deployed to:", contractAddress);

  // Datos del token
  const stageName = "Design Phase";
  const stageDescription = "Initial design of the project";
  const stageURI = "https://example.com/metadata/design-phase.json";

  // Llama a `createStage` para mintear un token
  console.log("Minting a new token...");
  await projectStages.createStage(stageName, stageDescription, stageURI);

  // Verifica el tokenURI del token con ID 0
  const tokenId = 0; // Verificamos específicamente el token con ID 0
  const tokenURI = await projectStages.tokenURI(tokenId);
  console.log(`Token URI for token ID ${tokenId}: ${tokenURI}`);
}

// Manejo de errores
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

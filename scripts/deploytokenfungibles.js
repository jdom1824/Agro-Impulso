const hre = require("hardhat");

async function main() {
  // Obtén las cuentas (asumimos que Hardhat proporciona cuentas para pruebas)
  const [owner, recipient, newAdmin] = await hre.ethers.getSigners();

  // Suministro inicial de tokens en unidades directas
  const initialSupply = 1000n * 10n ** 18n; // 1000 FTK con 18 decimales

  // Despliega el contrato "TokenFungible"
  const TokenFungible = await hre.ethers.getContractFactory("TokenFungible");
  const token = await TokenFungible.deploy(initialSupply);

  // Espera a que el contrato sea desplegado
  await token.waitForDeployment();

  // Obtén la dirección del contrato desplegado
  const contractAddress = await token.getAddress();
  console.log("TokenFungible deployed to:", contractAddress);

  // 1. Obtener el administrador actual
  const admin = await token.admin();
  console.log("Admin address:", admin);

  // 2. Distribuir tokens (admin envía 100 FTK al recipient)
  const amountToDistribute = 100n * 10n ** 18n; // 100 FTK
  await token.distribute(recipient.address, amountToDistribute);
  console.log(`Distributed ${amountToDistribute / 10n ** 18n} FTK to ${recipient.address}`);

  // 3. Quemar tokens (owner quema 50 FTK)
  const amountToBurn = 50n * 10n ** 18n; // 50 FTK
  await token.connect(owner).burn(amountToBurn);
  console.log(`Burned ${amountToBurn / 10n ** 18n} FTK from ${owner.address}`);

  // 4. Actualizar el administrador (asignar newAdmin como nuevo admin)
  await token.updateAdmin(newAdmin.address);
  console.log("Admin updated to:", newAdmin.address);

  // 5. Verificar el nuevo administrador
  const updatedAdmin = await token.admin();
  console.log("New admin address:", updatedAdmin);
}

// Manejo de errores
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

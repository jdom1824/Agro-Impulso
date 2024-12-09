# **Contratos Inteligentes para la Gestión de Stakeholders e Implementación de Proyectos**

Este repositorio contiene dos contratos inteligentes diseñados para administrar y supervisar proyectos mediante blockchain. Los contratos están basados en los estándares ERC-20 y ERC-721 de OpenZeppelin, y cuentan con funcionalidades personalizadas para garantizar la transparencia, trazabilidad y no transferibilidad de los tokens.

---

## **1. StakeholderToken (ERC-20)**
El contrato **StakeholderToken** emite tokens no transferibles para los stakeholders del proyecto. Estos tokens representan la participación de cada stakeholder y les permiten monitorear el uso de recursos asignados.

### **Características principales:**
- **No transferibilidad:** Los tokens no pueden ser transferidos entre cuentas, garantizando que cada stakeholder retenga exclusivamente su participación.
- **Distribución controlada:** Solo el administrador del contrato puede asignar tokens a los stakeholders.
- **Quema de tokens:** Los stakeholders pueden quemar sus tokens si es necesario.
- **Actualización del administrador:** El administrador puede delegar su rol a otra dirección, asegurando flexibilidad en la gestión.

### **Funciones principales:**
- `distribute(address stakeholder, uint256 amount)`: Permite al administrador distribuir tokens a los stakeholders.
- `burn(uint256 amount)`: Permite a los stakeholders quemar sus propios tokens.
- `updateAdmin(address newAdmin)`: Cambia la dirección del administrador.

---

## **2. ProjectStages (ERC-721)**
El contrato **ProjectStages** gestiona las etapas de implementación del proyecto. Cada etapa se representa como un token único (ERC-721) que incluye metadatos específicos relacionados con el progreso.

### **Características principales:**
- **No transferibilidad:** Los tokens ERC-721 no pueden ser transferidos entre cuentas, asegurando que cada etapa esté vinculada exclusivamente al proyecto.
- **Creación de etapas:** Solo el administrador puede crear nuevas etapas del proyecto.
- **Registro de detalles:** Cada etapa incluye un nombre, descripción, estado de finalización y una marca de tiempo.
- **Finalización de etapas:** El administrador puede marcar una etapa como completada.
- **Actualización del administrador:** Se permite transferir el rol de administrador a otra dirección.

### **Funciones principales:**
- `createStage(string memory name, string memory description, string memory uri)`: Crea una nueva etapa del proyecto con metadatos únicos.
- `completeStage(uint256 stageId)`: Marca una etapa como completada.
- `updateAdmin(address newAdmin)`: Cambia la dirección del administrador.

---

## **Requisitos de instalación**
Para implementar los contratos, es necesario contar con las siguientes herramientas instaladas:
- **Node.js** y **npm**
- **Hardhat** para el desarrollo y pruebas de contratos inteligentes
- Biblioteca de OpenZeppelin:
  ```bash
  npm install @openzeppelin/contracts


  ## **Instalación y Pruebas**

1. [Preparación del Entorno](#preparación-del-entorno)
2. [Despliegue de Contratos](#despliegue-de-contratos)
   - 2.1 [Despliegue de StakeholderToken](#despliegue-de-stakeholdertoken)
   - 2.2 [Despliegue de ProjectStages](#despliegue-de-projectstages)
3. [Pruebas de Funcionalidad](#pruebas-de-funcionalidad)
   - 3.1 [Pruebas de StakeholderToken](#pruebas-de-stakeholdertoken)
   - 3.2 [Pruebas de ProjectStages](#pruebas-de-projectstages)
4. [Conclusión](#conclusión)

---

## **1. Preparación del Entorno**

Antes de comenzar, asegúrate de tener instalado [Node.js](https://nodejs.org/) y [Hardhat](https://hardhat.org/). Luego, clona este repositorio y navega al directorio del proyecto:

```bash
git clone https://github.com/jdom1824/Agro-Impulso.git
cd Agro-Impulso
```

Instala las dependencias necesarias:

```bash
npm install
```

---

## **2. Despliegue de Contratos**

### **2.1 Despliegue de StakeholderToken**

1. **Configuración del Script de Despliegue**:

   Crea un archivo en la carpeta `scripts` llamado `deployStakeholderToken.js` con el siguiente contenido:

   ```javascript
   const hre = require("hardhat");

   async function main() {
     const [admin] = await hre.ethers.getSigners();
     const initialSupply = hre.ethers.utils.parseEther("1000"); // 1000 tokens con 18 decimales

     const StakeholderToken = await hre.ethers.getContractFactory("StakeholderToken");
     const token = await StakeholderToken.deploy(initialSupply);

     await token.deployed();

     console.log("StakeholderToken desplegado en:", token.address);
   }

   main().catch((error) => {
     console.error(error);
     process.exitCode = 1;
   });
   ```

2. **Ejecución del Despliegue**:

   En la terminal, ejecuta:

   ```bash
   npx hardhat run scripts/deployStakeholderToken.js --network localhost
   ```

   Asegúrate de que tu nodo local de Ethereum esté en funcionamiento.

### **2.2 Despliegue de ProjectStages**

1. **Configuración del Script de Despliegue**:

   Crea un archivo en la carpeta `scripts` llamado `deployProjectStages.js` con el siguiente contenido:

   ```javascript
   const hre = require("hardhat");

   async function main() {
     const [admin] = await hre.ethers.getSigners();

     const ProjectStages = await hre.ethers.getContractFactory("ProjectStages");
     const projectStages = await ProjectStages.deploy();

     await projectStages.deployed();

     console.log("ProjectStages desplegado en:", projectStages.address);
   }

   main().catch((error) => {
     console.error(error);
     process.exitCode = 1;
   });
   ```

2. **Ejecución del Despliegue**:

   En la terminal, ejecuta:

   ```bash
   npx hardhat run scripts/deployProjectStages.js --network localhost
   ```

   Asegúrate de que tu nodo local de Ethereum esté en funcionamiento.

---

## **3. Pruebas de Funcionalidad**

### **3.1 Pruebas de StakeholderToken**

1. **Distribución de Tokens**:

   Después de desplegar el contrato, puedes interactuar con él para distribuir tokens a los stakeholders. Asegúrate de que la cuenta que realiza la distribución sea la del administrador.

   ```javascript
   const [admin, stakeholder] = await hre.ethers.getSigners();
   const StakeholderToken = await hre.ethers.getContractAt("StakeholderToken", tokenAddress);

   const amount = hre.ethers.utils.parseEther("100"); // 100 tokens
   await StakeholderToken.connect(admin).distribute(stakeholder.address, amount);
   ```

2. **Quema de Tokens**:

   Un stakeholder puede quemar sus propios tokens de la siguiente manera:

   ```javascript
   await StakeholderToken.connect(stakeholder).burn(amount);
   ```

3. **Actualización del Administrador**:

   El administrador puede transferir su rol a otra dirección:

   ```javascript
   await StakeholderToken.connect(admin).updateAdmin(newAdminAddress);
   ```

### **3.2 Pruebas de ProjectStages**

1. **Creación de una Nueva Etapa**:

   Solo el administrador puede crear nuevas etapas del proyecto:

   ```javascript
   const [admin] = await hre.ethers.getSigners();
   const ProjectStages = await hre.ethers.getContractAt("ProjectStages", projectStagesAddress);

   const stageName = "Design Phase";
   const stageDescription = "Initial design of the project";
   const stageURI = "https://example.com/metadata/design-phase.json";

   await ProjectStages.connect(admin).createStage(stageName, stageDescription, stageURI);
   ```

2. **Completar una Etapa**:

   El administrador puede marcar una etapa como completada:

   ```javascript
   const stageId = 0; // ID de la etapa a completar
   await ProjectStages.connect(admin).completeStage(stageId);
   ```

3. **Actualizar el Administrador**:

   Similar al contrato anterior, el administrador puede transferir su rol:

   ```javascript
   await ProjectStages.connect(admin).updateAdmin(newAdminAddress);
   ```

---

## **4. Conclusión**

Esta guía proporciona una visión general sobre cómo desplegar y probar los contratos inteligentes **StakeholderToken** y **ProjectStages**. Asegúrate de revisar y adaptar los scripts según las necesidades específicas de tu proyecto. Para más detalles, consulta la documentación oficial de [Hardhat](https://hardhat.org/) y [OpenZeppelin](https://openzeppelin.com/).



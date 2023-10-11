import { createDebugLogger, createPXEClient, waitForSandbox, } from "@aztec/aztec.js";
import { format } from "util";
const { PXE_URL = "http://localhost:8080" } = process.env;
async function main() {
    ////////////// CREATE THE CLIENT INTERFACE AND CONTACT THE SANDBOX //////////////
    const logger = createDebugLogger("token");
    // We create PXE client connected to the sandbox URL
    const pxe = createPXEClient(PXE_URL);
    // Wait for sandbox to be ready
    await waitForSandbox(pxe);
    const nodeInfo = await pxe.getNodeInfo();
    logger(format("Aztec Sandbox Info ", nodeInfo));
}
await main();
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiaW5kZXguanMiLCJzb3VyY2VSb290IjoiIiwic291cmNlcyI6WyIuLi9zcmMvaW5kZXgudHMiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFBQUEsT0FBTyxFQUtMLGlCQUFpQixFQUNqQixlQUFlLEVBR2YsY0FBYyxHQUNmLE1BQU0saUJBQWlCLENBQUM7QUFJekIsT0FBTyxFQUFFLE1BQU0sRUFBRSxNQUFNLE1BQU0sQ0FBQztBQUU5QixNQUFNLEVBQUUsT0FBTyxHQUFHLHVCQUF1QixFQUFFLEdBQUcsT0FBTyxDQUFDLEdBQUcsQ0FBQztBQUUxRCxLQUFLLFVBQVUsSUFBSTtJQUNqQixpRkFBaUY7SUFDakYsTUFBTSxNQUFNLEdBQUcsaUJBQWlCLENBQUMsT0FBTyxDQUFDLENBQUM7SUFFMUMsb0RBQW9EO0lBQ3BELE1BQU0sR0FBRyxHQUFHLGVBQWUsQ0FBQyxPQUFPLENBQUMsQ0FBQztJQUNyQywrQkFBK0I7SUFDL0IsTUFBTSxjQUFjLENBQUMsR0FBRyxDQUFDLENBQUM7SUFFMUIsTUFBTSxRQUFRLEdBQUcsTUFBTSxHQUFHLENBQUMsV0FBVyxFQUFFLENBQUM7SUFFekMsTUFBTSxDQUFDLE1BQU0sQ0FBQyxxQkFBcUIsRUFBRSxRQUFRLENBQUMsQ0FBQyxDQUFDO0FBQ2xELENBQUM7QUFFRCxNQUFNLElBQUksRUFBRSxDQUFDIn0=
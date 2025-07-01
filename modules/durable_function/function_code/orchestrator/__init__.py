
import azure.functions as func
import azure.durable_functions as df

def orchestrator_function(context: df.DurableOrchestrationContext):
    keyvault_result = yield context.call_activity("CreateKeyVault", {})
    github_repo = yield context.call_activity("CreateGitHubRepo", {})
    return {"keyvault": keyvault_result, "github_repo": github_repo}

main = df.Orchestrator.create(orchestrator_function)

package listener

import (
	"rest/assetTransfer"

	"github.com/gin-gonic/gin"
)

func setupRouter() *gin.Engine {

	r := gin.Default()

	r.POST("/invoke", assetTransfer.Invoke)
	r.POST("/query", assetTransfer.Query)
	return r
}

func Start() {

	r := setupRouter()
	r.Run(":7000")

}

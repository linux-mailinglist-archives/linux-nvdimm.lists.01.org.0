Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F1315084D
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 15:23:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF2B610FC3368;
	Mon,  3 Feb 2020 06:26:17 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.76.210; helo=huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AD3B210FC3367
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 06:26:15 -0800 (PST)
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id CEB0FD4404B5C2881A6C;
	Mon,  3 Feb 2020 14:22:56 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 14:22:56 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 14:22:56 +0000
Date: Mon, 3 Feb 2020 14:22:54 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 14/27] nvdimm/ocxl: Add support for near storage
 commands
Message-ID: <20200203142254.00007377@Huawei.com>
In-Reply-To: <20191203034655.51561-15-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	<20191203034655.51561-15-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: VY6BJIVLZAJHXBRK6TXUAXURJTXF6K3O
X-Message-ID-Hash: VY6BJIVLZAJHXBRK6TXUAXURJTXF6K3O
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Rob Herring  <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>,  Krzysztof Kozlowski  <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan" <maddy@linux.vnet.ibm.com>, "=?ISO-8859-1?Q?C=E9dric?= Le Goater  <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,  Hari Bathini  <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger
 .kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/VY6BJIVLZAJHXBRK6TXUAXURJTXF6K3O/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2019 14:46:42 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Similar to the previous patch, this adds support for near storage commands.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/nvdimm/ocxl/scm.c          |  6 +++++
>  drivers/nvdimm/ocxl/scm_internal.c | 41 ++++++++++++++++++++++++++++++
>  drivers/nvdimm/ocxl/scm_internal.h | 38 +++++++++++++++++++++++++++
>  3 files changed, 85 insertions(+)
> 
> diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> index 1e175f3c3cf2..6c16ca7fabfa 100644
> --- a/drivers/nvdimm/ocxl/scm.c
> +++ b/drivers/nvdimm/ocxl/scm.c
> @@ -310,12 +310,18 @@ static int scm_setup_command_metadata(struct scm_data *scm_data)
>  	int rc;
>  
>  	mutex_init(&scm_data->admin_command.lock);
> +	mutex_init(&scm_data->ns_command.lock);
>  
>  	rc = scm_extract_command_metadata(scm_data, GLOBAL_MMIO_ACMA_CREQO,
>  					  &scm_data->admin_command);
>  	if (rc)
>  		return rc;
>  
> +	rc = scm_extract_command_metadata(scm_data, GLOBAL_MMIO_NSCMA_CREQO,
> +					  &scm_data->ns_command);
> +	if (rc)
> +		return rc;
> +

Ah. So much for my comment in previous patch.  Ignore that...

>  	return 0;
>  }
>  
> diff --git a/drivers/nvdimm/ocxl/scm_internal.c b/drivers/nvdimm/ocxl/scm_internal.c
> index 7b11b56863fb..c405f1d8afb8 100644
> --- a/drivers/nvdimm/ocxl/scm_internal.c
> +++ b/drivers/nvdimm/ocxl/scm_internal.c
> @@ -132,6 +132,47 @@ int scm_admin_response_handled(const struct scm_data *scm_data)
>  				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_ACRA);
>  }
>  
> +int scm_ns_command_request(struct scm_data *scm_data, u8 op_code)
> +{
> +	u64 val;
> +	int rc = ocxl_global_mmio_read64(scm_data->ocxl_afu, GLOBAL_MMIO_CHI,
> +					 OCXL_LITTLE_ENDIAN, &val);
> +	if (rc)
> +		return rc;
> +
> +	if (!(val & GLOBAL_MMIO_CHI_NSCRA))
> +		return -EBUSY;
> +
> +	return scm_command_request(scm_data, &scm_data->ns_command, op_code);
> +}
> +
> +int scm_ns_response(const struct scm_data *scm_data)
> +{
> +	return scm_command_response(scm_data, &scm_data->ns_command);
> +}
> +
> +int scm_ns_command_execute(const struct scm_data *scm_data)
> +{
> +	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_HCI,
> +				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_HCI_NSCRW);
> +}
> +
> +bool scm_ns_command_complete(const struct scm_data *scm_data)
> +{
> +	u64 val = 0;
> +	int rc = scm_chi(scm_data, &val);
> +
> +	WARN_ON(rc);
> +
> +	return (val & GLOBAL_MMIO_CHI_NSCRA) != 0;
> +}
> +
> +int scm_ns_response_handled(const struct scm_data *scm_data)
> +{
> +	return ocxl_global_mmio_set64(scm_data->ocxl_afu, GLOBAL_MMIO_CHIC,
> +				      OCXL_LITTLE_ENDIAN, GLOBAL_MMIO_CHI_NSCRA);
> +}
> +
>  void scm_warn_status(const struct scm_data *scm_data, const char *message,
>  		     u8 status)
>  {
> diff --git a/drivers/nvdimm/ocxl/scm_internal.h b/drivers/nvdimm/ocxl/scm_internal.h
> index 9bff684cd069..9575996a89e7 100644
> --- a/drivers/nvdimm/ocxl/scm_internal.h
> +++ b/drivers/nvdimm/ocxl/scm_internal.h
> @@ -108,6 +108,7 @@ struct scm_data {
>  	struct ocxl_context *ocxl_context;
>  	void *metadata_addr;
>  	struct command_metadata admin_command;
> +	struct command_metadata ns_command;
>  	struct resource scm_res;
>  	struct nd_region *nd_region;
>  	char fw_version[8+1];
> @@ -176,6 +177,42 @@ int scm_admin_command_complete_timeout(const struct scm_data *scm_data,
>   */
>  int scm_admin_response_handled(const struct scm_data *scm_data);
>  
> +/**
> + * scm_ns_command_request() - Issue a near storage command request
> + * @scm_data: a pointer to the SCM device data
> + * @op_code: The op-code for the command
> + * Returns an identifier for the command, or negative on error
> + */
> +int scm_ns_command_request(struct scm_data *scm_data, u8 op_code);
> +
> +/**
> + * scm_ns_response() - Validate a near storage response
> + * @scm_data: a pointer to the SCM device data
> + * Returns the status code of the command, or negative on error
> + */
> +int scm_ns_response(const struct scm_data *scm_data);
> +
> +/**
> + * scm_ns_command_execute() - Notify the controller to start processing a pending near storage command
> + * @scm_data: a pointer to the SCM device data
> + * Returns 0 on success, negative on error
> + */
> +int scm_ns_command_execute(const struct scm_data *scm_data);
> +
> +/**
> + * scm_ns_command_complete() - Is a near storage command executing
> + * scm_data: a pointer to the SCM device data
> + * Returns true if the previous admin command has completed
> + */
> +bool scm_ns_command_complete(const struct scm_data *scm_data);
> +
> +/**
> + * scm_ns_response_handled() - Notify the controller that the near storage response has been handled
> + * scm_data: a pointer to the SCM device data
> + * Returns 0 on success, negative on failure
> + */
> +int scm_ns_response_handled(const struct scm_data *scm_data);
> +
>  /**
>   * scm_warn_status() - Emit a kernel warning showing a command status.
>   * @scm_data: a pointer to the SCM device data
> @@ -184,3 +221,4 @@ int scm_admin_response_handled(const struct scm_data *scm_data);
>   */
>  void scm_warn_status(const struct scm_data *scm_data, const char *message,
>  		     u8 status);
> +
Stray blank line!

Now we are into the real nitpicks.  Not enough coffee.

Jonathan

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

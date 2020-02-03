Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC35150945
	for <lists+linux-nvdimm@lfdr.de>; Mon,  3 Feb 2020 16:11:55 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2A54710FC3368;
	Mon,  3 Feb 2020 07:15:12 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.176.76.210; helo=huawei.com; envelope-from=jonathan.cameron@huawei.com; receiver=<UNKNOWN> 
Received: from huawei.com (lhrrgout.huawei.com [185.176.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id DF4D710FC3361
	for <linux-nvdimm@lists.01.org>; Mon,  3 Feb 2020 07:15:09 -0800 (PST)
Received: from lhreml702-cah.china.huawei.com (unknown [172.18.7.108])
	by Forcepoint Email with ESMTP id 3C76168F46C989B83057;
	Mon,  3 Feb 2020 15:11:50 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 lhreml702-cah.china.huawei.com (10.201.108.43) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 3 Feb 2020 15:11:50 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 3 Feb 2020
 15:11:49 +0000
Date: Mon, 3 Feb 2020 15:11:48 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alastair D'Silva <alastair@au1.ibm.com>
Subject: Re: [PATCH v2 22/27] nvdimm/ocxl: Implement the heartbeat command
Message-ID: <20200203151148.00000ae0@Huawei.com>
In-Reply-To: <20191203034655.51561-23-alastair@au1.ibm.com>
References: <20191203034655.51561-1-alastair@au1.ibm.com>
	<20191203034655.51561-23-alastair@au1.ibm.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Message-ID-Hash: WQBUI4PABIQEZT7A4VGOIWZKONFVEICU
X-Message-ID-Hash: WQBUI4PABIQEZT7A4VGOIWZKONFVEICU
X-MailFrom: jonathan.cameron@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: alastair@d-silva.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Frederic Barrat <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Rob Herring  <robh@kernel.org>, Anton Blanchard <anton@ozlabs.org>,  Krzysztof Kozlowski  <krzk@kernel.org>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, Madhavan Srinivasan" <maddy@linux.vnet.ibm.com>, "=?ISO-8859-1?Q?C=E9dric?= Le Goater  <clg@kaod.org>, Anju T Sudhakar <anju@linux.vnet.ibm.com>,  Hari Bathini  <hbathini@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Greg Kurz" <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger
 .kernel.org, linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org, linux-mm@kvack.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WQBUI4PABIQEZT7A4VGOIWZKONFVEICU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2019 14:46:50 +1100
Alastair D'Silva <alastair@au1.ibm.com> wrote:

> From: Alastair D'Silva <alastair@d-silva.org>
> 
> The heartbeat admin command is a simple admin command that exercises
> the communication mechanisms within the controller.
> 
> This patch issues a heartbeat command to the card during init to ensure
> we can communicate with the card's crontroller.

controller

> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> ---
>  drivers/nvdimm/ocxl/scm.c | 43 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/nvdimm/ocxl/scm.c b/drivers/nvdimm/ocxl/scm.c
> index 8a30c887b5ed..e8b34262f397 100644
> --- a/drivers/nvdimm/ocxl/scm.c
> +++ b/drivers/nvdimm/ocxl/scm.c
> @@ -353,6 +353,44 @@ static bool scm_is_usable(const struct scm_data *scm_data)
>  	return true;
>  }
>  
> +/**
> + * scm_heartbeat() - Issue a heartbeat command to the controller
> + * @scm_data: a pointer to the SCM device data
> + * Return: 0 if the controller responded correctly, negative on error
> + */
> +static int scm_heartbeat(struct scm_data *scm_data)
> +{
> +	int rc;
> +
> +	mutex_lock(&scm_data->admin_command.lock);
> +
> +	rc = scm_admin_command_request(scm_data, ADMIN_COMMAND_HEARTBEAT);
> +	if (rc)
> +		goto out;
> +
> +	rc = scm_admin_command_execute(scm_data);
> +	if (rc)
> +		goto out;
> +
> +	rc = scm_admin_command_complete_timeout(scm_data, ADMIN_COMMAND_HEARTBEAT);
> +	if (rc < 0) {
> +		dev_err(&scm_data->dev, "Heartbeat timeout\n");
> +		goto out;
> +	}
> +
> +	rc = scm_admin_response(scm_data);
> +	if (rc < 0)
> +		goto out;
> +	if (rc != STATUS_SUCCESS)
> +		scm_warn_status(scm_data, "Unexpected status from heartbeat", rc);
> +
> +	rc = scm_admin_response_handled(scm_data);
> +
> +out:
> +	mutex_unlock(&scm_data->admin_command.lock);
> +	return rc;
> +}
> +
>  /**
>   * allocate_scm_minor() - Allocate a minor number to use for an SCM device
>   * @scm_data: The SCM device to associate the minor with
> @@ -1508,6 +1546,11 @@ static int scm_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err;
>  	}
>  
> +	if (scm_heartbeat(scm_data)) {
> +		dev_err(&pdev->dev, "SCM Heartbeat failed\n");
> +		goto err;
> +	}
> +
>  	elapsed = 0;
>  	timeout = scm_data->readiness_timeout + scm_data->memory_available_timeout;
>  	while (!scm_is_usable(scm_data)) {

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

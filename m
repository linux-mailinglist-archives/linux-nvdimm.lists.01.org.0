Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7633314FA75
	for <lists+linux-nvdimm@lfdr.de>; Sat,  1 Feb 2020 21:03:28 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 1C3FF10FC317B;
	Sat,  1 Feb 2020 12:06:31 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=198.145.29.99; helo=mail.kernel.org; envelope-from=vishal@kernel.org; receiver=<UNKNOWN> 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id B62451011367C
	for <linux-nvdimm@lists.01.org>; Sat,  1 Feb 2020 12:06:27 -0800 (PST)
Received: from gamestarV3L (c-71-237-40-145.hsd1.co.comcast.net [71.237.40.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A20F720643;
	Sat,  1 Feb 2020 20:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580587390;
	bh=GFHDrtDrOQaTllRtsYDI6O/S6mLDYlusAGVy5stXSbA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nTH/BvzK2+KDTLTlyT5SX746N5F60UiqQyLNNElIKAHLW/Dlxfc1b1mkbbC5AeOdi
	 bGwAYIAdXaXGlWycxat1T6+SHCgdQI8I6Q5Pu15aahm0q+oly8/5d1LKmYXSMOeGAb
	 qiSCx6Un5obLMz98b9tRlEHlLrsfjHspIcHnVE/w=
Message-ID: <0e09387cd5f2df5f19c9aa5494cc9be2ff7c14de.camel@kernel.org>
Subject: Re: [PATCH RFC] MAINTAINERS: clarify maintenance of nvdimm testing
 tool
From: Vishal Verma <vishal@kernel.org>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Dan Williams
 <dan.j.williams@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Dave
 Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Date: Sat, 01 Feb 2020 13:03:08 -0700
In-Reply-To: <20200201170933.924-1-lukas.bulwahn@gmail.com>
References: <20200201170933.924-1-lukas.bulwahn@gmail.com>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Message-ID-Hash: BXNQ7VRYO6VP4LDHNLDSEL4GHB2USL5X
X-Message-ID-Hash: BXNQ7VRYO6VP4LDHNLDSEL4GHB2USL5X
X-MailFrom: vishal@kernel.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/BXNQ7VRYO6VP4LDHNLDSEL4GHB2USL5X/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, 2020-02-01 at 18:09 +0100, Lukas Bulwahn wrote:
> The git history shows that the files under ./tools/testing/nvdimm are
> being developed and maintained by the LIBNVDIMM maintainers.
> 
> This was identified with a small script that finds all files only
> belonging to "THE REST" according to the current MAINTAINERS file, and I
> acted upon its output.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> This is a RFC patch based on what I could see as an outsider to nvdimm.
> Dan, please pick this patch if it reflects the real responsibilities.
> 
> applies cleanly on current master and next-20200131
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Looks good, thanks for catching this, Lukas.

Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1f77fb8cdde3..929386123257 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9564,6 +9564,7 @@ F:	drivers/acpi/nfit/*
>  F:	include/linux/nd.h
>  F:	include/linux/libnvdimm.h
>  F:	include/uapi/linux/ndctl.h
> +F:	tools/testing/nvdimm/
>  
>  LICENSES and SPDX stuff
>  M:	Thomas Gleixner <tglx@linutronix.de>

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

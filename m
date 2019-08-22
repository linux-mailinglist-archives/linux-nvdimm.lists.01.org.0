Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 205ED9A143
	for <lists+linux-nvdimm@lfdr.de>; Thu, 22 Aug 2019 22:41:29 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6FDE320214B23;
	Thu, 22 Aug 2019 13:42:28 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 170F020213F07
 for <linux-nvdimm@lists.01.org>; Thu, 22 Aug 2019 13:42:26 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 56600C010897;
 Thu, 22 Aug 2019 20:41:25 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CAD00100194E;
 Thu, 22 Aug 2019 20:41:24 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH 2/2] libdaxctl: point to migrate-device-model for
 dax-class errors
References: <20190822203635.17926-1-vishal.l.verma@intel.com>
 <20190822203635.17926-2-vishal.l.verma@intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 22 Aug 2019 16:41:23 -0400
In-Reply-To: <20190822203635.17926-2-vishal.l.verma@intel.com> (Vishal Verma's
 message of "Thu, 22 Aug 2019 14:36:35 -0600")
Message-ID: <x49pnkxndak.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 22 Aug 2019 20:41:25 +0000 (UTC)
X-BeenThere: linux-nvdimm@lists.01.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request@lists.01.org?subject=subscribe>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Vishal Verma <vishal.l.verma@intel.com> writes:

> When a dax-bus vs. dax-class expectation causes a failure, such as when
> reconfiguring device modes, print an error message directly pointing the
> user to the daxctl-migrate-device-model command.
>
> Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
> Reported-by: Jeff Moyer <jmoyer@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  daxctl/lib/libdaxctl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/daxctl/lib/libdaxctl.c b/daxctl/lib/libdaxctl.c
> index 44842b9..c0a859c 100644
> --- a/daxctl/lib/libdaxctl.c
> +++ b/daxctl/lib/libdaxctl.c
> @@ -917,6 +917,7 @@ static int daxctl_dev_enable(struct daxctl_dev *dev, enum daxctl_dev_mode mode)
>  
>  	if (!device_model_is_dax_bus(dev)) {
>  		err(ctx, "%s: error: device model is dax-class\n", devname);
> +		err(ctx, "%s: see man daxctl-migrate-device-model\n", devname);
>  		return -EOPNOTSUPP;
>  	}
>  
> @@ -962,6 +963,7 @@ DAXCTL_EXPORT int daxctl_dev_disable(struct daxctl_dev *dev)
>  
>  	if (!device_model_is_dax_bus(dev)) {
>  		err(ctx, "%s: error: device model is dax-class\n", devname);
> +		err(ctx, "%s: see man daxctl-migrate-device-model\n", devname);
>  		return -EOPNOTSUPP;
>  	}

Reviewed-by: Jeff Moyer <jmoyer@redhat.com>

Thanks, Vishal!
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

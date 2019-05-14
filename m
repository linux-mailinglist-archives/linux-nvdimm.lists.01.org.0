Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E271CFAA
	for <lists+linux-nvdimm@lfdr.de>; Tue, 14 May 2019 21:12:50 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 27A2F2127545D;
	Tue, 14 May 2019 12:12:48 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=linux-nvdimm@lists.01.org 
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id A013C21268F8E
 for <linux-nvdimm@lists.01.org>; Tue, 14 May 2019 12:12:46 -0700 (PDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8AFDD20675;
 Tue, 14 May 2019 19:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1557861166;
 bh=Dx8fO3TTAFVbhjdjmVSXfGcWo/4xM9XJT2npi4xsxtc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=toauLP82s6SvK8V1KkHf5COFmXqXrCdzvWsSIFzpnOMz7HsK8pGBWSn2riYujnQm3
 UI2pj0XEpWNT5f3qUGUCkuemRm2ajtG8i/wdw9VqAHsfrUmDKzFPIQ/O90P7kZZGPL
 U0nCodj8lpkzjPsBWsi9XCyThfy2fiK8twsrFumQ=
Date: Tue, 14 May 2019 21:12:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2 1/6] drivers/base/devres: Introduce
 devm_release_action()
Message-ID: <20190514191243.GA17226@kroah.com>
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
 <155727336530.292046.2926860263201336366.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <155727336530.292046.2926860263201336366.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, linux-nvdimm@lists.01.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Bjorn Helgaas <bhelgaas@google.com>, akpm@linux-foundation.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, May 07, 2019 at 04:56:05PM -0700, Dan Williams wrote:
> The devm_add_action() facility allows a resource allocation routine to
> add custom devm semantics. One such user is devm_memremap_pages().
> 
> There is now a need to manually trigger devm_memremap_pages_release().
> Introduce devm_release_action() so the release action can be triggered
> via a new devm_memunmap_pages() api in a follow-on change.
> 
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/base/devres.c  |   24 +++++++++++++++++++++++-
>  include/linux/device.h |    1 +
>  2 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/devres.c b/drivers/base/devres.c
> index e038e2b3b7ea..0bbb328bd17f 100644
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -755,10 +755,32 @@ void devm_remove_action(struct device *dev, void (*action)(void *), void *data)
>  
>  	WARN_ON(devres_destroy(dev, devm_action_release, devm_action_match,
>  			       &devres));
> -
>  }
>  EXPORT_SYMBOL_GPL(devm_remove_action);
>  
> +/**
> + * devm_release_action() - release previously added custom action
> + * @dev: Device that owns the action
> + * @action: Function implementing the action
> + * @data: Pointer to data passed to @action implementation
> + *
> + * Releases and removes instance of @action previously added by
> + * devm_add_action().  Both action and data should match one of the
> + * existing entries.
> + */
> +void devm_release_action(struct device *dev, void (*action)(void *), void *data)
> +{
> +	struct action_devres devres = {
> +		.data = data,
> +		.action = action,
> +	};
> +
> +	WARN_ON(devres_release(dev, devm_action_release, devm_action_match,
> +			       &devres));

What does WARN_ON help here?  are we going to start getting syzbot
reports of this happening?

How can this fail?

thanks,

greg k-h
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

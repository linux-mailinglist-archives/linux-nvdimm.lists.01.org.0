Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B680F865AE
	for <lists+linux-nvdimm@lfdr.de>; Thu,  8 Aug 2019 17:25:34 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 5AF3C21311BEC;
	Thu,  8 Aug 2019 08:28:03 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=209.132.183.28; helo=mx1.redhat.com; envelope-from=jmoyer@redhat.com;
 receiver=linux-nvdimm@lists.01.org 
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 1328721303095
 for <linux-nvdimm@lists.01.org>; Thu,  8 Aug 2019 08:28:02 -0700 (PDT)
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7DDDF30B8223;
 Thu,  8 Aug 2019 15:25:31 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com
 (segfault.boston.devel.redhat.com [10.19.60.26])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A80600F8;
 Thu,  8 Aug 2019 15:25:31 +0000 (UTC)
From: Jeff Moyer <jmoyer@redhat.com>
To: Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [ndctl PATCH] Documentation/namespace-description: Clarify
 label-less restrictions
References: <20190807221815.25782-1-vishal.l.verma@intel.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date: Thu, 08 Aug 2019 11:25:30 -0400
In-Reply-To: <20190807221815.25782-1-vishal.l.verma@intel.com> (Vishal Verma's
 message of "Wed, 7 Aug 2019 16:18:15 -0600")
Message-ID: <x49imr7d6hh.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Thu, 08 Aug 2019 15:25:31 +0000 (UTC)
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
Cc: linux-nvdimm@lists.01.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

Vishal Verma <vishal.l.verma@intel.com> writes:

> In the ndctl-create-namespace (and related) man pages, add a
> clarification note regarding some of the restrictions a user may see
> when operating on label-less namespaces.
>
> Link: https://github.com/pmem/ndctl/issues/52
> Reported-by: Jane Chu <jane.chu@oracle.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  Documentation/ndctl/namespace-description.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/ndctl/namespace-description.txt b/Documentation/ndctl/namespace-description.txt
> index 94999e5..5f294be 100644
> --- a/Documentation/ndctl/namespace-description.txt
> +++ b/Documentation/ndctl/namespace-description.txt
> @@ -18,6 +18,12 @@ the kernel's 'memmap=ss!nn' command line option (see the nvdimm wiki on
>  kernel.org), or NVDIMMs without a valid 'namespace index' in their label
>  area.
>  
> +NOTE: Label-less namespaces lack many of the features of their label-rich
> +cousins. For example, their size cannot be modified, or they cannot be
> +'destroyed' (only disabled). The only operation supported on them is to
> +change their 'mode', by adding on-media metadata which is then used to
> +identify an address abstraction mechanism for the namespace.

That last sentence is way too obtuse.  You could end it at the word
'mode'.

-Jeff
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

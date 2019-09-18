Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 119DCB6F06
	for <lists+linux-nvdimm@lfdr.de>; Wed, 18 Sep 2019 23:45:12 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C1E4D21A02937;
	Wed, 18 Sep 2019 14:44:21 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=134.134.136.65; helo=mga03.intel.com;
 envelope-from=ira.weiny@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id 29C5921A07096
 for <linux-nvdimm@lists.01.org>; Wed, 18 Sep 2019 14:44:20 -0700 (PDT)
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 18 Sep 2019 14:45:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,522,1559545200"; d="scan'208";a="338457730"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
 by orsmga004.jf.intel.com with ESMTP; 18 Sep 2019 14:45:07 -0700
Date: Wed, 18 Sep 2019 14:45:07 -0700
From: Ira Weiny <ira.weiny@intel.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] libnvdimm/nfit_test: Fix acpi_handle redefinition
Message-ID: <20190918214506.GA20171@iweiny-DESK2.sc.intel.com>
References: <20190918042148.77553-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190918042148.77553-1-natechancellor@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
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
Cc: linux-nvdimm@lists.01.org, linux-kernel@vger.kernel.org,
 clang-built-linux@googlegroups.com, Jason Gunthorpe <jgg@mellanox.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Sep 17, 2019 at 09:21:49PM -0700, Nathan Chancellor wrote:
> After commit 62974fc389b3 ("libnvdimm: Enable unit test infrastructure
> compile checks"), clang warns:
> 
> In file included from
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/iomap.c:15:
> ../drivers/nvdimm/../../tools/testing/nvdimm/test/nfit_test.h:206:15:
> warning: redefinition of typedef 'acpi_handle' is a C11 feature
> [-Wtypedef-redefinition]
> typedef void *acpi_handle;
>               ^
> ../include/acpi/actypes.h:424:15: note: previous definition is here
> typedef void *acpi_handle;      /* Actually a ptr to a NS Node */
>               ^
> 1 warning generated.
> 
> The include chain:
> 
> iomap.c ->
>     linux/acpi.h ->
>         acpi/acpi.h ->
>             acpi/actypes.h
>     nfit_test.h
> 
> Avoid this by including linux/acpi.h in nfit_test.h, which allows us to
> remove both the typedef and the forward declaration of acpi_object.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/660
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
> 
> I know that every maintainer has their own thing with the number of
> includes in each header file; this issue can be solved in a various
> number of ways, I went with the smallest diff stat. Please solve it in a
> different way if you see fit :)
> 
>  tools/testing/nvdimm/test/nfit_test.h | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/tools/testing/nvdimm/test/nfit_test.h b/tools/testing/nvdimm/test/nfit_test.h
> index 448d686da8b1..0bf5640f1f07 100644
> --- a/tools/testing/nvdimm/test/nfit_test.h
> +++ b/tools/testing/nvdimm/test/nfit_test.h
> @@ -4,6 +4,7 @@
>   */
>  #ifndef __NFIT_TEST_H__
>  #define __NFIT_TEST_H__
> +#include <linux/acpi.h>
>  #include <linux/list.h>
>  #include <linux/uuid.h>
>  #include <linux/ioport.h>
> @@ -202,9 +203,6 @@ struct nd_intel_lss {
>  	__u32 status;
>  } __packed;
>  
> -union acpi_object;
> -typedef void *acpi_handle;
> -
>  typedef struct nfit_test_resource *(*nfit_test_lookup_fn)(resource_size_t);
>  typedef union acpi_object *(*nfit_test_evaluate_dsm_fn)(acpi_handle handle,
>  		 const guid_t *guid, u64 rev, u64 func,
> -- 
> 2.23.0
> 
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

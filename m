Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A39D172C2D
	for <lists+linux-nvdimm@lfdr.de>; Fri, 28 Feb 2020 00:23:02 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 3809A10FC3639;
	Thu, 27 Feb 2020 15:23:52 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=209.85.210.68; helo=mail-ot1-f68.google.com; envelope-from=robherring2@gmail.com; receiver=<UNKNOWN> 
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0ACCD10FC359A
	for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 15:23:49 -0800 (PST)
Received: by mail-ot1-f68.google.com with SMTP id r16so918740otd.2
        for <linux-nvdimm@lists.01.org>; Thu, 27 Feb 2020 15:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UkIj7Br6bPd7hbW7TV5UiV4FHsIuHQGX64PWFr24Elw=;
        b=B+0TjGtL8A4g+IPOstmuqAce3wxzFXjj5w7IFlTv7nqKP+xouujiVd8t1ZyBXhguew
         HtA7QasSoKGDOIfnmwt15bb6QYWqzlrOv6tPKdgAepqj+2oSWuMLXZh1mALHyjHUYJLL
         rvzP3HNL2qEzOgOZxZ6ulCKK2xt533advsG2OoRmvs0MKeAx8OC7n3o0xibrQBlda6cw
         g4VD6x7mQQLKwv/uZ3Pk6nrFgoQCQ3C5yjsb75Iw1DI+63GIZW7deujv/PhPAlL6rQe7
         oz4sXPRVc7+z6h25pzz4sWx9Fac3xnvnv4Zpp0T3sHl/cAmChkAlitM55+DoN71JzdfB
         YhPw==
X-Gm-Message-State: APjAAAXhkbiEzWXNxCiQlWPTMl9CYidDKYtgsWEDrrbtGtscusdvmSiC
	3Z+M3UAAuac4FR+3CmxrGQ==
X-Google-Smtp-Source: APXvYqwyoGSeOvDsr/b/4MBxlzKifGUIKH2KNXIq/Dsvt2qo0CMzRCuC3CpAFxDHEcT2vx8OeH8M/A==
X-Received: by 2002:a9d:12a2:: with SMTP id g31mr1069694otg.283.1582845777179;
        Thu, 27 Feb 2020 15:22:57 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n25sm2496905oic.6.2020.02.27.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 15:22:55 -0800 (PST)
Received: (nullmailer pid 15847 invoked by uid 1000);
	Thu, 27 Feb 2020 23:22:53 -0000
Date: Thu, 27 Feb 2020 17:22:53 -0600
From: Rob Herring <robh@kernel.org>
To: Alistair Delva <adelva@google.com>
Subject: Re: [PATCH v3 3/3] dt-bindings: pmem-region: Document memory-region
Message-ID: <20200227232253.GA5966@bogus>
References: <20200224021029.142701-1-adelva@google.com>
 <20200224021029.142701-3-adelva@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200224021029.142701-3-adelva@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Message-ID-Hash: TO7WI35ZRENDREI4EOM2GJHMWEOW6MC3
X-Message-ID-Hash: TO7WI35ZRENDREI4EOM2GJHMWEOW6MC3
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-kernel@vger.kernel.org, Kenny Root <kroot@google.com>, devicetree@vger.kernel.org, linux-nvdimm@lists.01.org, kernel-team@android.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TO7WI35ZRENDREI4EOM2GJHMWEOW6MC3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sun, Feb 23, 2020 at 06:10:29PM -0800, Alistair Delva wrote:
> From: Kenny Root <kroot@google.com>
> 
> Add documentation and example for memory-region in pmem.
> 
> Signed-off-by: Kenny Root <kroot@google.com>
> Signed-off-by: Alistair Delva <adelva@google.com>
> Cc: "Oliver O'Halloran" <oohall@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-nvdimm@lists.01.org
> Cc: kernel-team@android.com
> ---
> [v3: adelva: remove duplicate "From:"]
>  .../devicetree/bindings/pmem/pmem-region.txt  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pmem/pmem-region.txt b/Documentation/devicetree/bindings/pmem/pmem-region.txt
> index 5cfa4f016a00..0ec87bd034e0 100644
> --- a/Documentation/devicetree/bindings/pmem/pmem-region.txt
> +++ b/Documentation/devicetree/bindings/pmem/pmem-region.txt
> @@ -29,6 +29,18 @@ Required properties:
>  		in a separate device node. Having multiple address ranges in a
>  		node implies no special relationship between the two ranges.
>  
> +		This property may be replaced or supplemented with a
> +		memory-region property. Only one of reg or memory-region
> +		properties is required.
> +
> +	- memory-region:
> +		Reference to the reserved memory node. The reserved memory
> +		node should be defined as per the bindings in
> +		reserved-memory.txt

Though we've never enforced it, but /reserved-memory should be within 
the bounds of /memory node(s). Is that the intent here? If so, how does 
that work? Wouldn't all the memory be persistent then? Or some other 
system processor is preserving the contents?

> +
> +		This property may be replaced or supplemented with a reg
> +		property. Only one of reg or memory-region is required.
> +
>  Optional properties:
>  	- Any relevant NUMA assocativity properties for the target platform.
>  
> @@ -63,3 +75,20 @@ Examples:
>  		volatile;
>  	};
>  
> +
> +	/*
> +	 * This example uses a reserved-memory entry instead of
> +	 * specifying the memory region directly in the node.
> +	 */
> +
> +	reserved-memory {
> +		pmem_1: pmem@5000 {
> +			no-map;

Just add 'compatible = "pmem-region";' here and be done with it. Why add 
a layer of indirection?

> +			reg = <0x00005000 0x00001000>;
> +		};
> +	};
> +
> +	pmem@1 {

No 'reg', so shouldn't have a unit-address here.

> +		compatible = "pmem-region";
> +		memory-region = <&pmem_1>;
> +	};
> -- 
> 2.25.0.265.gbab2e86ba0-goog
> 
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

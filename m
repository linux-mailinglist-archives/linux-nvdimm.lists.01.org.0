Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9AD3098F1
	for <lists+linux-nvdimm@lfdr.de>; Sun, 31 Jan 2021 00:51:46 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 2EFD5100EC1E4;
	Sat, 30 Jan 2021 15:51:44 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id BF44B100EC1E1
	for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:51:41 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id z9so217717pjl.5
        for <linux-nvdimm@lists.01.org>; Sat, 30 Jan 2021 15:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=cxvqbAo1IAIrwLB5kk+h8Luaw/WcNq7od57uwR/z/0A=;
        b=PjLjww8QTw6X6rVMAjtISyXtX7JMmqVaUJx3F60RM3ylFSLWRRcZCFrQlsjCSBGBqx
         Oj3eIeIel+lx5s/2LzA2cqzsOlBvs+jrSV4AXQBePenX9TqRNh4fBF2xa1vy/ZURdeOn
         +lhC0/eWjRwZcBS/1uE7a0/fxUpCmQEsIlkvVUw8XTrYgT7HEkD84ilH2PhECtGuizOl
         3L/Qf/himoTN1JGUyeYCivImS0tAyPYb9OeJvkMbXST578xzSCdUkQFxivOMQrwZRtAE
         nxCiaSxwoehw8rIP5fQZOuvdxKVzXZHozdLwXh4cjAQrPf6k9Zf1rWPHmWo72HtJywGU
         U2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=cxvqbAo1IAIrwLB5kk+h8Luaw/WcNq7od57uwR/z/0A=;
        b=lNtDIUJpsBnQY4vVwdDV7hG0nUX6bLXLCJpP6Nr5OsiiBZg1qohwlTGLzU9k/duNks
         iMqS4h9UlY3z00R5O3ok7D9wzpP7oBK2776CvNWJlGBdLHH5aKLoHjSLtHL0cEi3+eFT
         FvcRnZA7VliN3TBNnNmcnSFOlbVvUG55jKzEQOYACnBENr0+G9mYH0UNtwxd82CL74E+
         O5q7Zr5EPZSV/eNVpoKtcJtTCkre3NewEpcGz85Vu2oGt6f4dfN9oQN+wO7233pfLHlR
         8Irthpa+LwA+12YJqnKwgPO5zohME4LvMWSQ0cSt7q0XA9xxvUGXafGxy1RF6ijGWoZo
         YDyg==
X-Gm-Message-State: AOAM5338cUez6xUBONkuZFg1UoWo4o9CFMFYinfWBTFJWE5i1k8ePcWl
	TmUhX1VXI2kyAnA8VxRIM7GVEw==
X-Google-Smtp-Source: ABdhPJyDODycXpp/h5ITu3myrcAhtELZTjRYPPBKofKsdhKWkycX4cAiMkSboMfRs6hOUzcld1n8Cw==
X-Received: by 2002:a17:902:edcd:b029:df:d2b1:ecf0 with SMTP id q13-20020a170902edcdb02900dfd2b1ecf0mr11639635plk.15.1612050701068;
        Sat, 30 Jan 2021 15:51:41 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id c5sm12745797pfi.5.2021.01.30.15.51.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 15:51:40 -0800 (PST)
Date: Sat, 30 Jan 2021 15:51:39 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
Message-ID: <54655f17-2e4a-cc1e-262c-b365e3de9b20@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-2-ben.widawsky@intel.com>
MIME-Version: 1.0
Message-ID-Hash: SNMZUAHJF3QLI5IUXECWZQB5FAVS4J2B
X-Message-ID-Hash: SNMZUAHJF3QLI5IUXECWZQB5FAVS4J2B
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/SNMZUAHJF3QLI5IUXECWZQB5FAVS4J2B/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, 29 Jan 2021, Ben Widawsky wrote:

> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> new file mode 100644
> index 000000000000..3b66b46af8a0
> --- /dev/null
> +++ b/drivers/cxl/Kconfig
> @@ -0,0 +1,35 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +menuconfig CXL_BUS
> +	tristate "CXL (Compute Express Link) Devices Support"
> +	depends on PCI
> +	help
> +	  CXL is a bus that is electrically compatible with PCI Express, but
> +	  layers three protocols on that signalling (CXL.io, CXL.cache, and
> +	  CXL.mem). The CXL.cache protocol allows devices to hold cachelines
> +	  locally, the CXL.mem protocol allows devices to be fully coherent
> +	  memory targets, the CXL.io protocol is equivalent to PCI Express.
> +	  Say 'y' to enable support for the configuration and management of
> +	  devices supporting these protocols.
> +
> +if CXL_BUS
> +
> +config CXL_MEM
> +	tristate "CXL.mem: Endpoint Support"

Nit: "CXL.mem: Memory Devices" or "CXL Memory Devices: CXL.mem" might look 
better, but feel free to ignore.

Acked-by: David Rientjes <rientjes@google.com>
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

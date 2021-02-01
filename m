Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 853E830B24C
	for <lists+linux-nvdimm@lfdr.de>; Mon,  1 Feb 2021 22:51:23 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id A8B26100EA908;
	Mon,  1 Feb 2021 13:51:21 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::429; helo=mail-pf1-x429.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 1A9D4100EA903
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 13:51:18 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id j12so12537221pfj.12
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 13:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=X0Q/ZUQ4hKoawWN2B+locX1+Bltm6iYAtS5TX76PGV0=;
        b=JcEV6HVaeDaOOL0h5jY3uy6ve5Oys0MQOJ9U4nasE04exuRtFZbJpOIHVfWoYfle1J
         beI2sJhpCMqlNBKLZqSCeIYmtH728isIhOBGfVtCVebDEkV58CsHbbdI/9BFXOpwyhgi
         sPhuhxrbexd8U7yQKn0cHEHOHWqmMJ6kjMVmVst139NVTTYL8tb2UsrBxT/gZPOJhQTR
         bK3XnLbP8oRFa2gAPWEvZAP1vvQ7NrTtztwvuzEw5LaDNbCmxSFGSwPCx7byOdJRUt9C
         YTDIaUOkG8VOT/SQRV6U7po3pLvDqhE6/hv92a8C2KiIxOr0CrEWaO67fDJMNiOEuu4f
         93zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=X0Q/ZUQ4hKoawWN2B+locX1+Bltm6iYAtS5TX76PGV0=;
        b=JJ2OWosnAiq5+bHX0bpFnCWLuf8HyEhFmvEhEPFzLWeukMejs7o7ToYGhi7lSNSYuc
         gPav7d/QBZVUWAPcYl1KFXQZR+kyyll2iJOj6ToDdcYOT6hzJtkd5vHUNk6QMKcRY0nm
         AslEsY7HbybyNV2caJlIeUosMZ7G7OVDfO/QdXqrZ7KLU+FIwEnpzmjV9ffzdcBHuE0Z
         8qQ4JY5pcAceaDLAgUcfR6TDR/MDksDVj8yvrSU06eKUbhEQle52dHSfqmiKiLRqJjF9
         sH2v8qfpgZU/CDZrJGWIxexK2xCkNe5EykqjmH8+ZUFFzp1jSptT73pJbB1P50j3pKoI
         tTTg==
X-Gm-Message-State: AOAM533f41cBY/a4gQb/qzvSGysCXoYpd1H6EVveQa+We960DQJqmidS
	zQ7kECkRCyLuHo2M6Iw4/4aw+w==
X-Google-Smtp-Source: ABdhPJy0F0JZ9njhCDrVgT94zzxXJpyJDDqlsbZrnmv0MJhPc/jsWvO86HbtsOo2O3onCME70FZzTQ==
X-Received: by 2002:aa7:808b:0:b029:1ce:8a32:f5e8 with SMTP id v11-20020aa7808b0000b02901ce8a32f5e8mr3097800pff.34.1612216278371;
        Mon, 01 Feb 2021 13:51:18 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id a72sm20075000pfa.126.2021.02.01.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:51:17 -0800 (PST)
Date: Mon, 1 Feb 2021 13:51:16 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <20210201165352.wi7tzpnd4ymxlms4@intel.com>
Message-ID: <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com> <20210130002438.1872527-4-ben.widawsky@intel.com> <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com>
MIME-Version: 1.0
Message-ID-Hash: 2UCEP54GP3ISRD4L2BKCWP4FYZ7LVVLZ
X-Message-ID-Hash: 2UCEP54GP3ISRD4L2BKCWP4FYZ7LVVLZ
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/2UCEP54GP3ISRD4L2BKCWP4FYZ7LVVLZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> On 21-01-30 15:51:49, David Rientjes wrote:
> > On Fri, 29 Jan 2021, Ben Widawsky wrote:
> > 
> > > +static int cxl_mem_setup_mailbox(struct cxl_mem *cxlm)
> > > +{
> > > +	const int cap = cxl_read_mbox_reg32(cxlm, CXLDEV_MB_CAPS_OFFSET);
> > > +
> > > +	cxlm->mbox.payload_size =
> > > +		1 << CXL_GET_FIELD(cap, CXLDEV_MB_CAP_PAYLOAD_SIZE);
> > > +
> > > +	/* 8.2.8.4.3 */
> > > +	if (cxlm->mbox.payload_size < 256) {
> > > +		dev_err(&cxlm->pdev->dev, "Mailbox is too small (%zub)",
> > > +			cxlm->mbox.payload_size);
> > > +		return -ENXIO;
> > > +	}
> > 
> > Any reason not to check cxlm->mbox.payload_size > (1 << 20) as well and 
> > return ENXIO if true?
> 
> If some crazy vendor wanted to ship a mailbox larger than 1M, why should the
> driver not allow it?
> 

Because the spec disallows it :)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

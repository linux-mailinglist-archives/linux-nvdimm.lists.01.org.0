Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1815E30B3BB
	for <lists+linux-nvdimm@lfdr.de>; Tue,  2 Feb 2021 00:58:15 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 6B9A2100EA92C;
	Mon,  1 Feb 2021 15:58:13 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=rientjes@google.com; receiver=<UNKNOWN> 
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 117F7100EB347
	for <linux-nvdimm@lists.01.org>; Mon,  1 Feb 2021 15:58:11 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s23so12230825pgh.11
        for <linux-nvdimm@lists.01.org>; Mon, 01 Feb 2021 15:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=rTKu+xdzo+veIn6KkxdUI/A6PY5YQCPeNp5pTPUY3WQ=;
        b=VAHjN9JG4k8S/0sgPfPZHZIecEBvqimHWvOeTv0p4etlF/RojXQvnnCs/vX/pzsRi+
         JPqNGtAokQTisR9hN5EWazgXLVQsteZk19JWjvOj6SdOYPYubYFzsHPhGH32anzd6Id4
         GY1vNrTWQzIbLJhlWF8hr2bFzaiVj8n555uFHRRa5aB154AwlO1xOFiWwLuAdjmKZSry
         9qaZvMsCEWpJgZ89LTxQ10Wk9kujeXp8KaWHer4ZPnyoQk+eCODtNru6s2rViglqrz+x
         HWT8qkCRQf7zzO3hyItdZBMempeoMn+HJdCUXRgLGnKMruuxjDXTBBYvdoCmfqX8GhfV
         Ts/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=rTKu+xdzo+veIn6KkxdUI/A6PY5YQCPeNp5pTPUY3WQ=;
        b=QGt/HHxgL3Gvu4T7JXNcPRArIaM+qBdVxrW6L628UUXWZi0b7MG0qTV61y0vbDjPcU
         jZ1/U+E2uUi4WPdvPVyt1oEiZM1JY3FqFh/yO0ugT0JdTcX/pd+r2ARl/ikUhHD9RtLQ
         gfLwfKFupozqp34QMYN2Bi9YCx2R1EuoKK+2E8Dtm6XEmO5TR+FmlbUeL5Z9hNbapBcs
         qsGKwn4MlHckU+9zs8m952zMCCGUcoyarsr2pcFzRo2cXWu5lgq4I9oi7UHhrKdGui0u
         GxiZCVOzqpRY1rr080TXETVoTVo9ACnZdGdQ019TckT9g7OUBGlxNfTihEgQURXnwsr9
         8G1Q==
X-Gm-Message-State: AOAM533HiNKra0bjTmBnFIVthJ37CSOOE3mOigMIMd0LKniFsBXw5GPF
	/MVj0XE4EtwaM7SKRYousKnUZg==
X-Google-Smtp-Source: ABdhPJzXLITZFTLkuFtUNx2iXI7vVJGwTvh/frUwCyN9/C862kHXzQvcB66CzSuU6g9cBx9FOvRY0w==
X-Received: by 2002:a65:47c7:: with SMTP id f7mr19057541pgs.305.1612223891284;
        Mon, 01 Feb 2021 15:58:11 -0800 (PST)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id h15sm3044539pfr.62.2021.02.01.15.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 15:58:10 -0800 (PST)
Date: Mon, 1 Feb 2021 15:58:09 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Ben Widawsky <ben.widawsky@intel.com>
Subject: Re: [PATCH 03/14] cxl/mem: Find device capabilities
In-Reply-To: <20210201231718.2hwaqgn2f7kc7usw@intel.com>
Message-ID: <a789317e-2ac2-10a1-dedd-1851972e3d6b@google.com>
References: <234711bf-c03f-9aca-e0b5-ca677add3ea@google.com> <20210201165352.wi7tzpnd4ymxlms4@intel.com> <32f33dd-97a-8b1c-d488-e5198a3d7748@google.com> <20210201215857.ud5cpg7hbxj2j5bx@intel.com> <b46ed01-3f1-6643-d371-7764c3bde4f8@google.com>
 <20210201222859.lzw3gvxuqebukvr6@intel.com> <20210201223314.qh24uxd7ajdppgfl@intel.com> <f86149f8-3aea-9d8c-caa9-62771bf22cb5@google.com> <20210201225052.vrrvuxrsgmddjzbb@intel.com> <79b98f60-151b-6c80-65c3-91a37699d121@google.com>
 <20210201231718.2hwaqgn2f7kc7usw@intel.com>
MIME-Version: 1.0
Message-ID-Hash: C7PB7SVJDRDQVXKHPAHWBNM7WKGU5SZW
X-Message-ID-Hash: C7PB7SVJDRDQVXKHPAHWBNM7WKGU5SZW
X-MailFrom: rientjes@google.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-cxl@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, Chris Browy <cbrowy@avery-design.com>, Christoph Hellwig <hch@infradead.org>, Jon Masters <jcm@jonmasters.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Randy Dunlap <rdunlap@infradead.org>, daniel.lll@alibaba-inc.com, "John Groves (jgroves)" <jgroves@micron.com>, "Kelley, Sean V" <sean.v.kelley@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/C7PB7SVJDRDQVXKHPAHWBNM7WKGU5SZW/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Mon, 1 Feb 2021, Ben Widawsky wrote:

> > I haven't seen the update to 8.2.8.4.5 to know yet :)
> > 
> > You make a good point of at least being able to interact with the driver.  
> > I think you could argue that if the driver binds, then the payload size is 
> > accepted, in which case it would be strange to get an EINVAL when using 
> > the ioctl with anything >1MB.
> > 
> > Concern was that if we mask off the reserved bits from the command 
> > register that we could be masking part of the payload size that is being 
> > passed if the accepted max is >1MB.  Idea was to avoid any possibility of 
> > this inconsistency.  If this is being checked for ioctl, seems like it's 
> > checking reserved bits.
> > 
> > But maybe I should just wait for the spec update.
> 
> Well, I wouldn't hold your breath (it would be an errata in this case anyway).
> My preference would be to just allow allow mailbox payload size to be 2^31 and
> not deal with this.
> 
> My question was how strongly do you feel it's an error that should prevent
> binding.
> 

I don't have an objection to binding, but doesn't this require that the 
check in cxl_validate_cmd_from_user() guarantees send_cmd->size_in cannot 
be greater than 1MB?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

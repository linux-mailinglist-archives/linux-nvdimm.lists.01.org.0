Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C80111C13B
	for <lists+linux-nvdimm@lfdr.de>; Thu, 12 Dec 2019 01:22:08 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 01ECD1011351D;
	Wed, 11 Dec 2019 16:25:29 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.139.110.120; helo=us-smtp-1.mimecast.com; envelope-from=pbonzini@redhat.com; receiver=<UNKNOWN> 
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com [205.139.110.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 0DCF51011351B
	for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 16:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1576110121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ska3bIPmsdQtnj/4meb46bcvVz/4NO14TTW8PGBXyDI=;
	b=IX4wp1BWbBjFf+jVcMVxnwJpk5c69eaDoeXP5/4qA2aFXjm8jxRi5JQ5pqYbOtj1zsirGC
	et1jRtB4Hab931vLIp8rzEh3k8+fjkH7FJjHPKhOr/lEr2woeB1R0DBkP138DhYykYQpFz
	rq71uARJ54cWU6DvO/m5soEVIQk8Bdo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-fej3sRqRMP2ZZt0TApHSmw-1; Wed, 11 Dec 2019 19:21:59 -0500
Received: by mail-wm1-f69.google.com with SMTP id q26so69928wmq.8
        for <linux-nvdimm@lists.01.org>; Wed, 11 Dec 2019 16:21:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ska3bIPmsdQtnj/4meb46bcvVz/4NO14TTW8PGBXyDI=;
        b=ZHbjRQQHGddShbOYcLi3fJWPrnPCmBlX3Usm3GxuhyK6ebtKhdo18833thi4otKrsz
         qAmGQ662Ve8HltWFxmUsRdWQprcuC8BuB9fNKCnCCZgHf8ffVi1u7G8uXxCGyeS8AIfc
         0aiekAcwKTRzMkNdGbBvyc+HJyxQreUSyYMcZ2QE3gM/57vec7b5Qsp+XtofGiUSaV0q
         lPkp5VniHEZSkyaCb4w1dT8UNUKIqXS75SbtgzERGinIaw35QhK1QkfHexuppN8gC9bc
         85FgQMhTR/oDIVCI/cqztAS92yu1MzZoUEStRtueIjrgAVZ2UVZcXCJlYZrITcliy+5o
         DvRQ==
X-Gm-Message-State: APjAAAVhfu9e+Hi6ywOG3OgjbVoM6xDtEpMstMlp0r6CR4aF/t4ThclU
	J2AINZw+MpEDDKQ2cKfsNlj8GWbu+cchn1l9v6rKX4KtxYSaMRXJ79LPSD30OiUUMFfZPriPNNo
	uj7qwSvKqR1ipOf/sB4k/
X-Received: by 2002:adf:f58a:: with SMTP id f10mr2889589wro.105.1576110118022;
        Wed, 11 Dec 2019 16:21:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqxGJwEdVkyaU2oXUwh6CTh2f90dtYsbxxgMNCxSyknFWlvYkVEzD3KyBhe96t/+ML4ibwigNw==
X-Received: by 2002:adf:f58a:: with SMTP id f10mr2889571wro.105.1576110117837;
        Wed, 11 Dec 2019 16:21:57 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9? ([2001:b07:6468:f312:e9bb:92e9:fcc3:7ba9])
        by smtp.gmail.com with ESMTPSA id c9sm4002416wmc.47.2019.12.11.16.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2019 16:21:57 -0800 (PST)
Subject: Re: [PATCH v4 2/2] kvm: Use huge pages for DAX-backed files
To: Barret Rhoden <brho@google.com>, Dan Williams <dan.j.williams@intel.com>,
 David Hildenbrand <david@redhat.com>, Dave Jiang <dave.jiang@intel.com>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20191211213207.215936-1-brho@google.com>
 <20191211213207.215936-3-brho@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5abef720-c329-13c3-ff93-b4b58a08721c@redhat.com>
Date: Thu, 12 Dec 2019 01:21:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191211213207.215936-3-brho@google.com>
Content-Language: en-US
X-MC-Unique: fej3sRqRMP2ZZt0TApHSmw-1
X-Mimecast-Spam-Score: 0
Message-ID-Hash: 7BU4NGTMI6MJDZDXZ5VFHIT7NGPX4HBV
X-Message-ID-Hash: 7BU4NGTMI6MJDZDXZ5VFHIT7NGPX4HBV
X-MailFrom: pbonzini@redhat.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: linux-nvdimm@lists.01.org, x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, jason.zeng@intel.com
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/7BU4NGTMI6MJDZDXZ5VFHIT7NGPX4HBV/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 11/12/19 22:32, Barret Rhoden wrote:
> +	/*
> +	 * Our caller grabbed the KVM mmu_lock with a successful
> +	 * mmu_notifier_retry, so we're safe to walk the page table.
> +	 */
> +	switch (dev_pagemap_mapping_shift(hva, current->mm)) {
> +	case PMD_SHIFT:
> +	case PUD_SIZE:
> +		return true;
> +	}
> +	return false;

Should this simply be "> PAGE_SHIFT"?

Paolo
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

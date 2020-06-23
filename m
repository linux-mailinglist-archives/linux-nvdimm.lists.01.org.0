Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A87206557
	for <lists+linux-nvdimm@lfdr.de>; Tue, 23 Jun 2020 23:48:29 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 8D5AA10FC3777;
	Tue, 23 Jun 2020 14:48:27 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AE5B210112D6F
	for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 14:48:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id h28so5284156edz.0
        for <linux-nvdimm@lists.01.org>; Tue, 23 Jun 2020 14:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XKFP4XmM+fzPiSTcosfxpar/wTtCL35clRf++Z9m9ME=;
        b=F1lsia2rHf1QjZHwmwFyb3rl/n1GTyxCp+pL4CQHVcYaIpRBQYuLp4VEvV3gTVzC6T
         Y0ZYtALWifMR47OpgIRXM+ZsNLyRakdttcIh1QXcyW2CAiGQCsWbnM2I+gyyYl6mOZI/
         JhkUDtfG2igjjw82AeihWkKCAY8uQjW8NlLFku1IHUco3VDRgf26H5wOdykBehKwbKD7
         zXhSocoxUkZekHACS2I7zQH1A44s44Foxo8kZI1Gfhg1+uuLgPmOLjIew4Ex/0pwVJpV
         iKTFVQcUjN50tdl3MkEkyPSFTjCpyPvys3RVxOb0l88vM9dYQ/ZIXUKrz2dOPmEtnOWg
         aZyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XKFP4XmM+fzPiSTcosfxpar/wTtCL35clRf++Z9m9ME=;
        b=XU4XFECJjJ0XByTCOna56WxBKz+hv/ZjnTB0qhuqKJ58alNc1UGlYS4sJ3l+j44bjn
         vCTp0EaNYbVmiCvnoVH6zPzEdNtAQNq4ZAV06lWf5dKquyTDQfT7lQFGsBYbIcMN3QqH
         JdNEStl+Xjb5wvDHxHR2effpOPqaRTPr+SmRhbLNDMX+Qu2GOjUbJeOqQTPm+1n8v4KX
         afAkuZ7l07Sgrn0XjorV9N6ROWbiglFm6eBHJxELiTWGZPABwANCg+/zfkwMgVUAPgw/
         Je1ug7iMwZRU5ytXIxmUD8r6+ojX4Vjhjgp/O5Duh9TNn2VWszV9j6IV81aVL72dhah5
         eWpA==
X-Gm-Message-State: AOAM531VoeVyFqW4TptU3P526LOot9LaZvoxuTUWS2fFdwUVwmpqN7xD
	kMFCsQvX3FVbm8iPdoI2M6K0Dx9d1HgrE9UoGRJelQ==
X-Google-Smtp-Source: ABdhPJzeX9nxsXA3Zu7wxZMKFugqzwy3MnzLxu2GT5SKfmIE4H+3rsuLUjVpi+jCAWejZXkG9uDyiRHh1AF4zIqmMME=
X-Received: by 2002:a50:a1e7:: with SMTP id 94mr23236130edk.165.1592948903362;
 Tue, 23 Jun 2020 14:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200623201745.GG21350@casper.infradead.org>
In-Reply-To: <20200623201745.GG21350@casper.infradead.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 23 Jun 2020 14:48:12 -0700
Message-ID: <CAPcyv4jDfm10pGBJHJYA_=C0-+JMor-r7ViAJSJ=u4ZW0FqAow@mail.gmail.com>
Subject: Re: [RFC] Make the memory failure blast radius more precise
To: Matthew Wilcox <willy@infradead.org>
Message-ID-Hash: 5EZNR7642M2U75XWVS37ZCU6PXZAAYF3
X-Message-ID-Hash: 5EZNR7642M2U75XWVS37ZCU6PXZAAYF3
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Naoya Horiguchi <naoya.horiguchi@nec.com>, linux-edac@vger.kernel.org, Linux MM <linux-mm@kvack.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, "Darrick J. Wong" <darrick.wong@oracle.com>, david <david@fromorbit.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/5EZNR7642M2U75XWVS37ZCU6PXZAAYF3/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Jun 23, 2020 at 1:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>
>
> Hardware actually tells us the blast radius of the error, but we ignore
> it and take out the entire page.  We've had a customer request to know
> exactly how much of the page is damaged so they can avoid reconstructing
> an entire 2MB page if only a single cacheline is damaged.
>
> This is only a strawman that I did in an hour or two; I'd appreciate
> architectural-level feedback.  Should I just convert memory_failure() to
> always take an address & granularity?  Should I create a struct to pass
> around (page, phys, granularity) instead of reconstructing the missing
> pieces in half a dozen functions?  Is this functionality welcome at all,
> or is the risk of upsetting applications which expect at least a page
> of granularity too high?
>
> I can see places where I've specified a plain PAGE_SHIFT insted of
> interrogating a compound page for its size.  I'd probably split this
> patch up into two or three pieces for applying.
>
> I've also blindly taken out the call to unmap_mapping_range().  Again,
> the customer requested that we not do this.  That deserves to be in its
> own patch and properly justified.

I had been thinking that we could not do much with the legacy
memory-failure reporting model and that applications that want a new
model would need to opt-into it. This topic also dovetails with what
Dave and I had been discussing in terms coordinating memory error
handling with the filesystem which may have more information about
multiple mappings of a DAX page (reflink) [1].

[1]: http://lore.kernel.org/r/20200311063942.GE10776@dread.disaster.area
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

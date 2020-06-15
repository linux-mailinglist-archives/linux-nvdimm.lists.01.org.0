Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CCB1F9FE1
	for <lists+linux-nvdimm@lfdr.de>; Mon, 15 Jun 2020 21:06:30 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 4CB80110E5FDE;
	Mon, 15 Jun 2020 12:06:29 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::543; helo=mail-ed1-x543.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 3288B110E5FDE
	for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 12:06:25 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id m21so12316331eds.13
        for <linux-nvdimm@lists.01.org>; Mon, 15 Jun 2020 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=olEteVHhdq8yEDgr22qHHqiXrLTHF0iSZEQd5+cZ3i4=;
        b=HSNkMcTTIJYSJKd5fm1hFo5NcqHjRoxIw9VgW1AhFtGY9q9s3jG/lafai0QvhBZr08
         2Y4ZLVLUtytxhUfEPHb1eZmuRg8e9yZxh8SLuY2aN/KaQkJsB9yjK0JgsWhHJ7II1hOi
         MbzutdQ2EmUCxu4XGefggHJztuN9VKRrf2vkgbC6TXvw0w6wsNhlivnabF/nAfsh/YkD
         Yp3x3MpBVO9oeDsfB3ByuiFpM6BwvmmqayHySEmWh1mgxM3adyKmDPL7RWzKcQgR2Fny
         1KEucQJszZ9hZW4wIurej5IV62ilDBRBy9Y6DhsgZBPlnmLs5K7sd+enkrlBA9fq7Cel
         A7bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=olEteVHhdq8yEDgr22qHHqiXrLTHF0iSZEQd5+cZ3i4=;
        b=eyzXxklmdpAq+S6XLZgnoLfoecAtieekMjyNQl3u+gSrCAPOyiKqw09vyZ+E4eVx69
         QhksfRViY90C15emPKeYJaEusQN80HtA2ycudKH+MN3KEs9x+t2PELuyBH+0scz9Thdh
         Di5x4pEuR/UekUTG8/yH0Cyl7vfRZKq81YVgux1V5DOw2dFlJLYX3EID3HwfOnkHFlmN
         VY64USGGTELDgCfAuB52YybCxvMA28Bj4coQ2Itf8Mja16X7AibNmWb2al8B98erdWrB
         LrYvgoLhWePEXSosHw7NKHKuME+Rfp8MWPeXt5VvmvulUr22DEd5khgZDlV8HSnNdGJg
         Ywpw==
X-Gm-Message-State: AOAM530CkDQ9fOJ2mr4cwE6Lk6I7v7D5ELrj1b6O0/Db4it/peqewXi3
	zWE4MzdplRSaDfncX5wRo+acGdyuZzD/Po+dEkJAzg==
X-Google-Smtp-Source: ABdhPJxzUL4eHu5m5GntRVMoggAuJPY06Z4cx3u9jUOhbsuFvVxxME5LmBO1gfqVV0ymEVBSdTRsALwmBpbSSrtyiis=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr24735245edt.383.1592247983077;
 Mon, 15 Jun 2020 12:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <158889473309.2292982.18007035454673387731.stgit@dwillia2-desk3.amr.corp.intel.com>
 <BYAPR11MB30963CB784B940A5CD58C4FAF0810@BYAPR11MB3096.namprd11.prod.outlook.com>
 <CAJZ5v0h0ax4N-Tk+MfAeAyJ_tDYPW5vseqUU49UShBKZ4+F6Bw@mail.gmail.com> <34641620.ChEHEh4gq6@kreacher>
In-Reply-To: <34641620.ChEHEh4gq6@kreacher>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 15 Jun 2020 12:06:11 -0700
Message-ID: <CAPcyv4iA+21rrwfZ9SdV903TiTo9sA7KfrKVQfLOO-612uanpQ@mail.gmail.com>
Subject: Re: [RFT][PATCH 2/3] ACPICA: Remove unused memory mappings on
 interpreter exit
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Message-ID-Hash: WXOUTVLBAP4LOEOJBNAGDVK3SXXOMYBB
X-Message-ID-Hash: WXOUTVLBAP4LOEOJBNAGDVK3SXXOMYBB
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: "Kaneda, Erik" <erik.kaneda@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>, Myron Stowe <myron.stowe@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Moore, Robert" <robert.moore@intel.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/WXOUTVLBAP4LOEOJBNAGDVK3SXXOMYBB/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Sat, Jun 13, 2020 at 12:29 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
[,,]
> > While I agree that this is still somewhat suboptimal, improving this
> > would require more changes in the OSL code.
>
> After writing the above I started to think about the extra changes needed
> to improve that and I realized that it would take making the OS layer
> support deferred memory unmapping, such that the unused mappings would be
> queued up for later removal and then released in one go at a suitable time.
>
> However, that would be sufficient to address the issue addressed by this
> series, because the deferred unmapping could be used in
> acpi_ev_system_memory_region_setup() right away and that would be a much
> simpler change than the one made in patch [1/3].
>
> So I went ahead and implemented this and the result is there in the
> acpica-osl branch in my tree, but it hasn't been built yet, so caveat
> emptor.  Anyway, please feel free to have a look at it still.

I'll have a look. However, I was just about to build a test kernel for
the original reporter of this problem with this patch set. Do you want
test feedback on that branch, or this set as is?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

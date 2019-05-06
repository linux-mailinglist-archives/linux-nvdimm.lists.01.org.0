Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7615384
	for <lists+linux-nvdimm@lfdr.de>; Mon,  6 May 2019 20:18:35 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id DF92C21250C9A;
	Mon,  6 May 2019 11:18:33 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com;
 envelope-from=pasha.tatashin@soleen.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id DF30021250479
 for <linux-nvdimm@lists.01.org>; Mon,  6 May 2019 11:18:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p26so16244882edr.2
 for <linux-nvdimm@lists.01.org>; Mon, 06 May 2019 11:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soleen.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HayB7sQuY+v6EOo4zgx5AzoxFFOqeB4N5OR8XF6r5Uc=;
 b=ZO0IGp0OlSdXA+IWacCTnCe28YL0KDN5WLR0iOy2RQwLUXZVopK4KJfjY+7Q/z9X6s
 SjuXLmGb7eUbUPJHlvDgd+B3s08Ybui1oQ9ioaIhBcDsAz6stlJCXGs9JZSL5YKh43lu
 Nwu+fb1XhtGFgnaFbhK852KIcA+Hirr1L1Uu2CPoxojTIdKceAWJbAZ7TBO6HNLfSXLH
 IqZeQ9Y3ShvtCySSy+qfuIwbk91roy5qHtFp8zbKkADnaXx4F2yKU1KCdSog3LdNJZ0V
 /oPFwD9Z4Ilb/jEbM5g4Mp2y3Hs7tChLQ697C0ly3r+YHVZPXTFzV9DXetIRIhfLCKSy
 AKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HayB7sQuY+v6EOo4zgx5AzoxFFOqeB4N5OR8XF6r5Uc=;
 b=Fx+KIIt/y/V7H9USlDGnf8kTKaTb3dOHWlGWOHzMsMtqjo8OMDMQEeab0+05JVt3AS
 jBrDVL2Z4v7nexiwGWTv6xAsZdWp2weqd5qsctNjaBk70zBhXLaWkLuibqeF2BMJR2BY
 wmnZBQ8OSsm4t5R4VhSE+PAVXC9Xwni3cRUTT/xdEObpyNtkuxScByd2WppHilXf2vEc
 xNtMES3xYlwqDIhAj0w0eOxNV5Q0blYmayjP2sSiSs4eOjFOibLPwLR0szyjehBhZvt2
 WQ6TsMC0gSEa2NaghSt+XGKcFeIcEIoCrBwPJn2S2MutA14uheKKuJG9/dPVkJ5b/uZF
 50kg==
X-Gm-Message-State: APjAAAViMsxx0fH7eTzDCJX0UR+WDdNP9C9s629twLZa9Bm7WUmgY50w
 Ac1J3LGVsnR65boBcIPy7ITYLZub9tOlS1FzWaLjqQ==
X-Google-Smtp-Source: APXvYqwHXBTigtDuKWMtEhHCcYHo0Ym7KuPj7imSV/QN0gZyF9gZvmtmygbEq5LNv1SmyCzL2+klGlSO4LgamYmNN1E=
X-Received: by 2002:a17:906:5c0f:: with SMTP id
 e15mr20354898ejq.151.1557166711352; 
 Mon, 06 May 2019 11:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502184337.20538-1-pasha.tatashin@soleen.com>
 <20190502184337.20538-3-pasha.tatashin@soleen.com>
 <cac721ed-c404-19d1-71d1-37c66df9b2a8@intel.com>
 <CAPcyv4greisKBSorzQWebcVOf2AqUH6DwbvNKMW0MQ5bCwYZrw@mail.gmail.com>
 <cf793443-c14a-a1e0-856e-15e416c7f874@intel.com>
In-Reply-To: <cf793443-c14a-a1e0-856e-15e416c7f874@intel.com>
From: Pavel Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 6 May 2019 14:18:20 -0400
Message-ID: <CA+CK2bAfjXCtRRV2DWy8huCvJ-y0L5cMvOh+9CS40WZfhx-aeg@mail.gmail.com>
Subject: Re: [v5 2/3] mm/hotplug: make remove_memory() interface useable
To: Dave Hansen <dave.hansen@intel.com>
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
Cc: Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
 Takashi Iwai <tiwai@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Linux MM <linux-mm@kvack.org>, Yaowei Bai <baiyaowei@cmss.chinamobile.com>,
 Ross Zwisler <zwisler@kernel.org>, Sasha Levin <sashal@kernel.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>, James Morris <jmorris@namei.org>,
 "Huang, Ying" <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Fengguang Wu <fengguang.wu@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Mon, May 6, 2019 at 2:04 PM Dave Hansen <dave.hansen@intel.com> wrote:
>
> On 5/6/19 11:01 AM, Dan Williams wrote:
> >>> +void __remove_memory(int nid, u64 start, u64 size)
> >>>  {
> >>> +
> >>> +     /*
> >>> +      * trigger BUG() is some memory is not offlined prior to calling this
> >>> +      * function
> >>> +      */
> >>> +     if (try_remove_memory(nid, start, size))
> >>> +             BUG();
> >>> +}
> >> Could we call this remove_offline_memory()?  That way, it makes _some_
> >> sense why we would BUG() if the memory isn't offline.
> > Please WARN() instead of BUG() because failing to remove memory should
> > not be system fatal.
>
> That is my preference as well.  But, the existing code BUG()s, so I'm
> OK-ish with this staying for the moment until we have a better handle on
> what all the callers do if this fails.

Yes, this is the reason why I BUG() here. The current code does this,
and I was not sure what would happen if we simply continue executing.
Of course, I would prefer to return failure, so the callers can act
appropriately, but let's make one thing at a time, this should not be
part of this series.

Thank you,
Pasha
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

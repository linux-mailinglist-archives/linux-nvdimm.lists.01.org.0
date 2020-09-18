Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B459527060C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 18 Sep 2020 22:12:18 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 09BDA151B3B6B;
	Fri, 18 Sep 2020 13:12:17 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::542; helo=mail-ed1-x542.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95361151B3B65
	for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 13:12:13 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id l17so7203129edq.12
        for <linux-nvdimm@lists.01.org>; Fri, 18 Sep 2020 13:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=58SVd9xQPAa3MMs+i2Y5r0SrMbzEeCTNJdX9BF17KGA=;
        b=uXpuzoga0nFIgtP+Hi/5AgmNxGuxqVy7HNh6hYVExZMoncmJVnErvj2kxbk/gLtbrw
         NXxpjAqgqMseDrkUdEViUwIw/kjrRhR9RurOiivQvShbKpS0PFr0+VgRU8tC+YUZpesi
         jMqKMzSNcEXk8x+ltiaigvivgWc0DA6xvUCnT2atdFwjlSb/kYWfxE6+NMFqwvYIwccg
         HJ/sd4AzELSg8UE0Ao9E1nT06ff2yi9kyBXN8lwt4xc0dZREFt7a+kcomGhlAlt630+y
         MDO8lKxSrXy7x90xx/e8WWApsixhmu4L+TW5V1fFgQ39Qi3LBF80QDUYyHiO4NlBaLjX
         js7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=58SVd9xQPAa3MMs+i2Y5r0SrMbzEeCTNJdX9BF17KGA=;
        b=n3dL9xiGTO2ibRvZhX5Kl/m6o0boMXBymjJJ4YoqQ/IdFCVxaS6GEDfxYos9+id4hW
         t+ceLsJk03Vh0O7ErTBTwZtxKxqfJkBwuFOPDeaf7DUcc5UW+4XaR+yFK6XW3zmpbIiW
         o+l8aQI6IV9ycsvUQ5zdvrXkAzv40b2/rGodVQYjfmVXkPYbeynphG6zdZcsuYKk+Ypi
         RH00tgNVhvU32A/o6cA0Xf1/ApJpjYVR7cYrqbYu3f4Gi3DTHlZTuepihH9/t+fn3Qpq
         nIbW9lunrissmQAZA+Cmii83+2ldeCwGXOi7TblPUVHQistvrQUR0KHbvL1f7IKToL43
         bk2Q==
X-Gm-Message-State: AOAM533kDgFMe5SBXY/NQfB9OEatYzfvjCbazdMhefEuAgN4W4sZcR+y
	3ZKvaFua+s1w+FDMvHBB26qMGlGZFNcEQQ7IQ5Nvtg==
X-Google-Smtp-Source: ABdhPJxOFFD0eSpbC1rYQXtCMYpl/WMVoZNQPs1/RmSK0a1T6JlJ73DDgUmklrxn2wqgaBjvvJ0V2aOf8fWVVWoqmF4=
X-Received: by 2002:aa7:c511:: with SMTP id o17mr41361709edq.300.1600459932144;
 Fri, 18 Sep 2020 13:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200916151445.450-1-jack@suse.cz> <CAPcyv4gfMY=k+SDsKWPPasZs9X=7schOgc=3VZSDj0kAbZcTTA@mail.gmail.com>
 <20200917104216.GB16097@quack2.suse.cz> <CAHKZfL0xC4OTe_HDg93HdinmxnpPVCAK3eweWCoo2CsbDTvNYA@mail.gmail.com>
 <CAPcyv4hfFg=+fX+iJtfNn29Q3-d+uy1U0EswM6035CV3VHJ2Ww@mail.gmail.com>
 <CAPcyv4iQyPP7_6EfwcHWiZ9Q_yxMPPbqL1_zjMQ=e4dsiH=fOA@mail.gmail.com> <CAHKZfL2pQ=wqVNPrf2q2GKGWz=S4NSKzPqJMsyd-yHKZu+EDGQ@mail.gmail.com>
In-Reply-To: <CAHKZfL2pQ=wqVNPrf2q2GKGWz=S4NSKzPqJMsyd-yHKZu+EDGQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 18 Sep 2020 13:12:00 -0700
Message-ID: <CAPcyv4hMndViSQegczOhCAZ2effuGWF0PDX7XMufspxSawPVUg@mail.gmail.com>
Subject: Re: [PATCH] dm: Call proper helper to determine dax support
To: Huang Adrian <adrianhuang0701@gmail.com>
Message-ID-Hash: HC2IHXXLLKVQMUI2NJVN4GYLKIV3PYFZ
X-Message-ID-Hash: HC2IHXXLLKVQMUI2NJVN4GYLKIV3PYFZ
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: Jan Kara <jack@suse.cz>, linux-nvdimm <linux-nvdimm@lists.01.org>, Coly Li <colyli@suse.de>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>, Adrian Huang12 <ahuang12@lenovo.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/HC2IHXXLLKVQMUI2NJVN4GYLKIV3PYFZ/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 18, 2020 at 5:41 AM Huang Adrian <adrianhuang0701@gmail.com> wrote:
[..]
> Interestingly, the command `lvm2-testsuite --only pvmove-abort-all.sh`
> passed on vanilla 5.9-rc5 (on my two boxes).
> Is it the same symptom (call trace) with my reported one?
>
> Could you please run the above-mentioned command on your box (w/wo
> Jan's patch plus my fixup)?

Thanks for the exact reproduction details. I was hitting a different
hang, but I was able to reproduce this regression / latent bug. Fix is
here:

https://lore.kernel.org/linux-nvdimm/160045867590.25663.7548541079217827340.stgit@dwillia2-desk3.amr.corp.intel.com/T/#u
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5623F27903B
	for <lists+linux-nvdimm@lfdr.de>; Fri, 25 Sep 2020 20:24:59 +0200 (CEST)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 56516154E302A;
	Fri, 25 Sep 2020 11:24:57 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::643; helo=mail-ej1-x643.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 6F4CB154E3013
	for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 11:24:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gx22so4911312ejb.5
        for <linux-nvdimm@lists.01.org>; Fri, 25 Sep 2020 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXgmtUU/9M0jPBUXCBFaK9jFUYs5RNAYLDl2lgNz+xk=;
        b=TJ1V1mcLvIdUyYEBPeZZf8Tfgct5pegeON5gPiyhBZr1rj17HE/LSz06S1yqB2DxYo
         qUgsLXOmkEy5RUYXfcsu0ev0abrlc4ZZG1Kd1c1m4lTDq68R5G9rMfjf6bsPVZCPaC2c
         hjmBZ2gsyAsr5qvl7+14h/LhF3yKRti91f/lEFgZMmWKoNpWPuRvpAQzJuHh4plWqn2a
         SG0Fl+mvzZFp1BwxsoO5Oa4eeHjtBqhkQjxPY1U1QpTism1hHmxOxed/IqXCTtbR4Wj2
         RtTIhITx/uLerytC7wwKxf8ACB/2IIW3+wJoebKPD28UIrlYlJBVsNJlYgeIrBLUskhW
         Rvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXgmtUU/9M0jPBUXCBFaK9jFUYs5RNAYLDl2lgNz+xk=;
        b=PI+sruwvhyzYhPv+4dbj0S7eYCgMSM4dKeDGGFcwqHH+yihEtvQ4KiTSQHTeWkclo7
         x85HNs2tP1TX+BGyzXk6ZLyLVy7rPnb9GNIi6GqImPJDSLnIE3rMh2anVcgFksU24Y+R
         Xv23ag/Ewga6TcdTHwK4lWC2mwCksFEW0eXe5K+Qn+h0zEuCg5d4y2v8nqna/s0cJbLA
         Tm6Zg141+e2qB99VcO8ssum9Yik4wKRnpBVndDk1FLWoWRbvXOBB0bOUUAOV1TGVT1+s
         i9YTn4ukd0u6QlMO14HBUQwgDQguenpOaNKS0cHPc5sz33tnZRBU/6MHFZRuICxMriVu
         IgbA==
X-Gm-Message-State: AOAM532oKXCSttUM1fUwZKoPryWroysQupUvq6+Q1O7cTuALBHSdhDqm
	ezAhOHJQ7W8gF5l5VHBuQsuASDIzncLW4QXfPlsejw==
X-Google-Smtp-Source: ABdhPJzSN+8TPy4k3k2Pvbt2ULzLKI4qrWjpydNNs/74YbTACwo+2SKE6EfKy9Pf30DhtxFV2BurROECzyjWqYIq3so=
X-Received: by 2002:a17:906:8143:: with SMTP id z3mr3919252ejw.323.1601058292066;
 Fri, 25 Sep 2020 11:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200925091806.1860663-1-yanaijie@huawei.com>
In-Reply-To: <20200925091806.1860663-1-yanaijie@huawei.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 25 Sep 2020 11:24:41 -0700
Message-ID: <CAPcyv4jgCp4_rSWs2SipiR3Jhz2jbSGWuLjtPExGDdTOEztAXA@mail.gmail.com>
Subject: Re: [PATCH] device-dax: include bus.h in super.c
To: Jason Yan <yanaijie@huawei.com>
Message-ID-Hash: ZIIAHDTIYXLMFDT3TYNUTDJZUS6YEGPC
X-Message-ID-Hash: ZIIAHDTIYXLMFDT3TYNUTDJZUS6YEGPC
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, Hulk Robot <hulkci@huawei.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/ZIIAHDTIYXLMFDT3TYNUTDJZUS6YEGPC/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 25, 2020 at 2:17 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> This addresses the following sparse warning:
>
> drivers/dax/super.c:452:6: warning: symbol 'run_dax' was not declared.
> Should it be static?

run_dax() is a core helper defined in drivers/dax/super.c that is
meant to hide the definition of 'struct dax_device' from the wider
kernel that does not need to poke into its internals. There's also no
need for drivers/dax/super.c to be given knowledge of other core
details that are contained within bus.h. So, I think this patch
provides no value and goes against the principle of least privilege
(https://en.wikipedia.org/wiki/Principle_of_least_privilege)
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

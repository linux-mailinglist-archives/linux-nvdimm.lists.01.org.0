Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [198.145.21.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B833F7B51E
	for <lists+linux-nvdimm@lfdr.de>; Tue, 30 Jul 2019 23:38:39 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 008AE212E8426;
	Tue, 30 Jul 2019 14:41:09 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::244; helo=mail-oi1-x244.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id D9D8921959CB2
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 14:41:06 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id m206so49055802oib.12
 for <linux-nvdimm@lists.01.org>; Tue, 30 Jul 2019 14:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=+5JOOn7SBmn+BXEukedT9HDXQ6WS/r4bECASKDsfPTc=;
 b=wPargsCx1nCKwYgN+UmNJ+Ig2yIDukdOFYcafHAoe3HixxhzXwRMveW8WJbYjiLDVB
 XbzprVIA35u37LGeX54iP4ILaKrn2ZhsHJ7HWatfCu+Dy3AK04gYp0qsDNO5JINxbU66
 793vBLMC/2q9GjCzIncgSDaS52sZ95bS4q3yUIBVFG0BqK7kBkiiL0rUkTy1gy785b/G
 HixoGYJN0KZsmAs7IKt+3EffEecPzG3ht9NV6iRwONmKHhzWMdcK5ojktOyBien+IE2z
 ZnpdPMHhrkvdWxeuLBaHFjco1kw0VqWIzURD3Kv3X0Zi1Xvi85u1GhDy0eXKzpdjXw/K
 RMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=+5JOOn7SBmn+BXEukedT9HDXQ6WS/r4bECASKDsfPTc=;
 b=sy+P1i3Ear0wRuurMsoD8pyf8KOc3lSd1IxOzz58LlDGFS3AMc77BO7qPHzvlaB/JP
 JZOGVROPvzr1C5rpRtHgjwOKjZZGUrwzoYQEhgTasLvDhl/TldcQrlXqwckYo6OIhWi5
 q0xnQ0KSckLsAjLoEOfGZgZmmVdkLUYP4H77lLSoJtFL1ae4YZjt+E6icfFasLaHFuvT
 Lq0coI3bS4lpjqTsrNn1nYpPTPN0TP7ZmIIyQ/hGNkhix3KVDiETAbkOrIw2dja00c3y
 GoFL4SR8wzOogWv1I6marSYV2S2hbRzIY7X+Vi9HSyFkVU/0ieRfMQh4UOqCFzZum09J
 x/7w==
X-Gm-Message-State: APjAAAWiAcp1YXXx0ZFpNC228VaCSbM+3zqmDCvpCagfFy+9e1BE39hB
 VgqHTV4TpZZLUQPD18Ky+Wwd4Y74YS0vWDkDlcdTeA==
X-Google-Smtp-Source: APXvYqz/vebOGKyx5iJtOjMRLpWnJO3JxlqPxCgJzVvyZc/nI/IYK9bwftHIvxiV8iym6ilmxvWFcSB3C9ypYO/5uNs=
X-Received: by 2002:aca:d80a:: with SMTP id p10mr58049607oig.105.1564522715513; 
 Tue, 30 Jul 2019 14:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190730113708.14660-1-pagupta@redhat.com>
 <2030283543.5419072.1564486701158.JavaMail.zimbra@redhat.com>
 <20190730190737.GA14873@redhat.com>
In-Reply-To: <20190730190737.GA14873@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 30 Jul 2019 14:38:24 -0700
Message-ID: <CAPcyv4i10K3QdSwa3EF9t8pS-QrB9YcBEMy49N1PnYQzCkBJCw@mail.gmail.com>
Subject: Re: dm: fix dax_dev NULL dereference
To: Mike Snitzer <snitzer@redhat.com>
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
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 device-mapper development <dm-devel@redhat.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Alasdair Kergon <agk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Tue, Jul 30, 2019 at 12:07 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> I staged the fix (which I tweaked) here:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.3&id=95b9ebb78c4c733f8912a195fbd0bc19960e726e

Thanks for picking this up Mike, but I'd prefer to just teach
dax_synchronous() to return false if the passed in dax_dev is NULL.
Thoughts?
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

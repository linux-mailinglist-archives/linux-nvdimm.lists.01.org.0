Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FFB74685C
	for <lists+linux-nvdimm@lfdr.de>; Fri, 14 Jun 2019 21:52:54 +0200 (CEST)
Received: from [127.0.0.1] (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id E510D2129F021;
	Fri, 14 Jun 2019 12:52:52 -0700 (PDT)
X-Original-To: linux-nvdimm@lists.01.org
Delivered-To: linux-nvdimm@lists.01.org
Received-SPF: Pass (sender SPF authorized) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::342; helo=mail-ot1-x342.google.com;
 envelope-from=dan.j.williams@intel.com; receiver=linux-nvdimm@lists.01.org 
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ml01.01.org (Postfix) with ESMTPS id C75C12129EBB3
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 12:52:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d17so3769730oth.5
 for <linux-nvdimm@lists.01.org>; Fri, 14 Jun 2019 12:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=intel-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=M1Rq8pqzLQULBhULrxVaHHYhqSJXnjqqmvnJVANgYFA=;
 b=ozJjCi5d70H8uZAFWn+43Iuobpjfr2Emm9osYa6coutPkyDHzRYGIPuItBJSiUtqbH
 dFPDRsZjHzW1gBpNSkONsf0AJ/rRRePG9mPM8GEMq9HiXacU9shoNW5zLHZXZdoZ3OPM
 Se8XMRpM4Le42mc/vlW9q4EkXcswQ3zlO6un17YmGk/0Jw6T5aw2MAZ0GNBeX6pBYiCX
 LFIE3WuQ4kcd6tuplcIAg20clu9yY5a2GwVdAWnCMpCXqc65GMPuuaazLauxE+fe3eMU
 e/+D6NKfLyuzzAosSeSUNiyAUDFrf2lDxXBQQVx0aaFh7bwlprRNiJIzn4kMvDWtH2Sw
 B/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=M1Rq8pqzLQULBhULrxVaHHYhqSJXnjqqmvnJVANgYFA=;
 b=GyG+Tnth3VSi0Ac96tecHYhWXmxAYnakE99J225JoS9RmCY3PytMqrG65+sKsuiPse
 pfShyjqV876YeAa++IhuVA9iC+AFAjE7Y7d2WvLvl/oma6IojZMFLeV8Fjn/5UCdN4Zt
 7OC49EEvRtoRXrY5ts+iXXm5zGYm4ozfF//ucFq5HsjZfHiCSjzYRHF5eHrunYpMeSTH
 wynN98FawCi+7/s5Mc4U3EJ99b9mxsBoNwYO++4OR8NCbSF5TuytWr6LDUkrCFcQc85H
 diMMwxd6mB2gLbmRufgsns6O96xb7M1x/W1i3z/cFOxcG01Q7HiEkceCZHcCDFYxpnaL
 Cjbw==
X-Gm-Message-State: APjAAAUnlYE2xkwa408cKTvWywR5p139KcuyJZVYYJtEFdHV/s5HTqo1
 cr3jWnVol1lTmVG1KKjHE6M9W4fLiXTT3PF2j/2dmg==
X-Google-Smtp-Source: APXvYqxCsVEejEo4gkKK02RjkYwV5FDU9XpCM0ky+mo3qv97O4koSiZbcE7H633DiplRWmzxvHlkS6G+6OiIJaSM/ik=
X-Received: by 2002:a9d:470d:: with SMTP id a13mr15158373otf.126.1560541970122; 
 Fri, 14 Jun 2019 12:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190614185222.30068-1-vishal.l.verma@intel.com>
In-Reply-To: <20190614185222.30068-1-vishal.l.verma@intel.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 14 Jun 2019 12:52:39 -0700
Message-ID: <CAPcyv4hjFB+y=ibae9fT6UBs=VeAC0NEWHrqzs2pnaeBHx-y_w@mail.gmail.com>
Subject: Re: [ndctl PATCH] libndctl/inject: Refuse error injection for BTT
 namespaces
To: Vishal Verma <vishal.l.verma@intel.com>
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
Cc: Marek de Rosier <marekx.de.rosier@intel.com>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-nvdimm-bounces@lists.01.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces@lists.01.org>

On Fri, Jun 14, 2019 at 11:52 AM Vishal Verma <vishal.l.verma@intel.com> wrote:
>
> Error injection on a BTT namespace would treat the namespace as 'raw'
> for the purposes of the injection. This can be useful for development,
> but to a user this can be surprising, as injecting with --block=1 would
> corrupt the BTT info block, and the BTT would be lost.
>
> The unit tests do not rely on injecting errors directly into a BTT
> namespace - they convert the namespace to 'raw' mode before performing
> such an injection. For development and testing purposes, we will still
> retain this ability by enforcing that the BTT namespace be explicitly
> forced into raw mode before injection.
>
> Reported-by: Marek de Rosier <marekx.de.rosier@intel.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Looks good,

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
_______________________________________________
Linux-nvdimm mailing list
Linux-nvdimm@lists.01.org
https://lists.01.org/mailman/listinfo/linux-nvdimm

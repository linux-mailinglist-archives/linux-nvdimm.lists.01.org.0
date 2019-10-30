Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0104EA5CC
	for <lists+linux-nvdimm@lfdr.de>; Wed, 30 Oct 2019 22:54:12 +0100 (CET)
Received: from new-ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id C53AE100EA55C;
	Wed, 30 Oct 2019 14:54:43 -0700 (PDT)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::743; helo=mail-qk1-x743.google.com; envelope-from=cai@lca.pw; receiver=<UNKNOWN> 
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id C48CF100EA55A
	for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 14:54:41 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d13so4557477qko.3
        for <linux-nvdimm@lists.01.org>; Wed, 30 Oct 2019 14:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=41dVk3HlaKb/dFjB8UnWPeItSsHUeTbp2B9Q6WI0tdI=;
        b=jbIvggOIeT93+HYPaTBumtry7oeGFtRGRR/RJZ//h55U0bXJOWNKOfcHnZsH8nOSWl
         ijjgihsoEFCZxaBjB/0RnqYBI1yXeuE4KsNREA7rDgbLcUukvlHQ7BiuLh8SnlAIY1Zj
         2teTt4r/7ljvLvpSxEbw21SmAMMe7xfYuqcf+z+bLbkEaCoF5KcFLv+vipKztqVqk2UR
         Fi0fMP14X7hf0Gl/7+UWABKMNrv18W5BFb/b9DVRJLD0CPzz44FiXlPDuwKMfz7KUOZg
         uGZIN1nJUZM0Wxck74k4CocTGv72D/HSth4B9ilouuvO2SdGzq1j3ykuB6nPpkCaeT/l
         n6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=41dVk3HlaKb/dFjB8UnWPeItSsHUeTbp2B9Q6WI0tdI=;
        b=A8jbM5/5MrmbNDVl5dS/63b2RxgoFLCEo8IS7TfoA02Qg+O4NyLGmlIjEaC41Er6ff
         MhFxeAJIXcCiIPLSIFsRyJappi4CGpZsxfCI1RR01SeWeagtnnn78v+Ry8yF6ZIst9Co
         7SNG9wAeg2BBrD/SBJ7o3+Utt9TjyOXWrYIQxCNVcC8Jv54dQIsvean0E7+Tt5dLX4MP
         nbjK48YgF50574y9AXOouOE7gyVKPd93C3qjCWlJuGvsRn79JeLYmD4QMfESBUpeI83b
         bD0HVudqVdyZj4sA0o2uoSpWVwP/YgyJcFc7uw4kqZF66/BbCQCNbUrZT8gkvWrPP1xm
         vCqg==
X-Gm-Message-State: APjAAAU6uSxNhUozuU5LilNnuYQO/ZhwdGkytLzr5/4NShyv8fyKA8xe
	DD+SDEad3yVJefyyL+Ntc8bBaBz2giTGpVKT
X-Google-Smtp-Source: APXvYqwrQ09V/5pkR6XSIY1CNfD1/GGL1Zz/FvP/T6FEFfnzt1OotLdGJngFwNtEvyKl0Z4cQVy96Q==
X-Received: by 2002:a37:4cd5:: with SMTP id z204mr2102084qka.153.1572472447368;
        Wed, 30 Oct 2019 14:54:07 -0700 (PDT)
Received: from ?IPv6:2600:1000:b063:e143:9455:99a5:c2db:fc9c? ([2600:1000:b063:e143:9455:99a5:c2db:fc9c])
        by smtp.gmail.com with ESMTPSA id n62sm769982qkn.47.2019.10.30.14.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Oct 2019 14:54:06 -0700 (PDT)
From: Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] nvdimm/btt: fix variable 'rc' set but not used
Date: Wed, 30 Oct 2019 17:54:05 -0400
Message-Id: <5E00893B-D36C-446F-9E71-54FB32772DA0@lca.pw>
References: <03cacc16f2fcd7cc74cf15c57070c78e73206e68.camel@intel.com>
In-Reply-To: <03cacc16f2fcd7cc74cf15c57070c78e73206e68.camel@intel.com>
To: "Verma, Vishal L" <vishal.l.verma@intel.com>
X-Mailer: iPhone Mail (17A878)
Message-ID-Hash: A7NFA2S3BSCEQNP4HTBCQMLHFVAPKV2G
X-Message-ID-Hash: A7NFA2S3BSCEQNP4HTBCQMLHFVAPKV2G
X-MailFrom: cai@lca.pw
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
CC: "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/A7NFA2S3BSCEQNP4HTBCQMLHFVAPKV2G/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



> On Oct 30, 2019, at 5:38 PM, Verma, Vishal L <vishal.l.verma@intel.com> wrote:
> 
> Good find! Since we're not really using rc later, we should just
> simplify this to:
> 
>    if (btt_map_write(...))
>        dev_warn_ratelimited(...)
>    goto out_rtt;

Ah, I thought about printing the rc as well at first, but it seems only return -EIO for errors, so I agree with you.
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

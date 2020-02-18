Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D6C162AD8
	for <lists+linux-nvdimm@lfdr.de>; Tue, 18 Feb 2020 17:41:05 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id 40ED710FC33E6;
	Tue, 18 Feb 2020 08:42:58 -0800 (PST)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:20::241; helo=mail-oi1-x241.google.com; envelope-from=dan.j.williams@intel.com; receiver=<UNKNOWN> 
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id AFF3A1007B1FD
	for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 08:42:55 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id a142so20706881oii.7
        for <linux-nvdimm@lists.01.org>; Tue, 18 Feb 2020 08:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p8K7bRgMIpoqIE67OrY5lFjC6s4gW3U9U0H2xoj25kw=;
        b=oid16IX7f7CHfsm6agFZdtMQgo0SiRT7u7TlInmVa8wfmQkPjI2PE7uAcn/BLB6i45
         Kjzk+N7PNIFzvVSxiZZOJDyT9Kw8l4IogvK5vI9tgDEderngrjcAlkC38mIqQcoXf/eH
         cmYZMFSPW2HgWGAJwOzre6HOFTu08anqPp2J05cZGpplXxD4/giON09LYBDBt4ub/g1T
         HUjZxgWE0/IbVc+rlpuyAZy84grJObAjLOX9E8JUS1xduhug9OkmUEsqBlGKIZWfCz8p
         jFg4asDnUKBTRyrC1mcM9xz1bfv3TMQoWR2Ywn4e8o5rbwRq32R+Gd3SJzn0w9UVFNpJ
         WbKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p8K7bRgMIpoqIE67OrY5lFjC6s4gW3U9U0H2xoj25kw=;
        b=ZPXPHLCTNiTFIBxaPBjSBNzZcbxljTuwYphP9lGjjW8tFfmV0cCAIwS8twB67M4RL/
         x6p2POJPVRrxV7dpf05H4guG4XFyoDSRPqiHjPiLJ387ZqcS+H1ZjDzzrTRAc4PZGbXf
         keiyBb8kNEwlU34u/D803NK+MqSIBeezGhBUcV10qzFglNqwhwOkxXPPoF/30aKtPBnU
         iG+LTWiWbX1IZ2fMFiKaMSjNLF4NZ8VShtLNp/K7OZN2gg/L0TipeF9xdcv5sszfaFBI
         D5e+Jw8XNMYNgv8+P+jyxW1MxDpUirISSsBiTtcFZN7Vo4Dz1DHdlRirpBxI693stxdu
         EWuQ==
X-Gm-Message-State: APjAAAUSjuJbGYKF10y/ZjSZJrBVqgx7nz1dIBd7edHSAyxZAH1tZu+R
	r0fcN4SFhFnVluK/yV2Ps9+V6z25MD/7iPEO/5peuA==
X-Google-Smtp-Source: APXvYqxKj389Ca7isA6lXFGih3cTi2B4mIYr7lceKx2QMSg6NIbiU0Fm0H3yxQ04HNpK9kjVtiKI3dPA4qJKh00QkiM=
X-Received: by 2002:aca:4c9:: with SMTP id 192mr1871066oie.105.1582044051997;
 Tue, 18 Feb 2020 08:40:51 -0800 (PST)
MIME-Version: 1.0
References: <20200218155314.89123-1-vaibhav@linux.ibm.com>
In-Reply-To: <20200218155314.89123-1-vaibhav@linux.ibm.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 18 Feb 2020 08:40:41 -0800
Message-ID: <CAPcyv4isdnEi=-EOv5EVu=6u7D32eLFLGWK0K5nQZa+9SMMGkQ@mail.gmail.com>
Subject: Re: [ndctl PATCH] ndctl,daxctl: Ensure allocated contexts are
 released before exit
To: Vaibhav Jain <vaibhav@linux.ibm.com>
Message-ID-Hash: 4QQU6GQ6O7QYEJU3VRLCDTQTROD3AMJU
X-Message-ID-Hash: 4QQU6GQ6O7QYEJU3VRLCDTQTROD3AMJU
X-MailFrom: dan.j.williams@intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation; nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size; news-moderation; no-subject; suspicious-header
CC: linux-nvdimm <linux-nvdimm@lists.01.org>, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
X-Mailman-Version: 3.1.1
Precedence: list
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/4QQU6GQ6O7QYEJU3VRLCDTQTROD3AMJU/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, Feb 18, 2020 at 7:53 AM Vaibhav Jain <vaibhav@linux.ibm.com> wrote:
>
> Presently main_handle_internal_command() will simply call exit() on
> the return value from run_builtin(). This prevents release of allocated
> contexts 'struct ndctl_ctx' or 'struct daxctl_ctx' when the main
> thread exits.
>

There is ultimately no leak since process exit cleans up all
resources. Does this address a functional problem, or is it just a
hygiene fixup?
_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org

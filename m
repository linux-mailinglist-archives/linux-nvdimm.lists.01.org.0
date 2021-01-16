Return-Path: <linux-nvdimm-bounces@lists.01.org>
X-Original-To: lists+linux-nvdimm@lfdr.de
Delivered-To: lists+linux-nvdimm@lfdr.de
Received: from ml01.01.org (ml01.01.org [IPv6:2001:19d0:306:5::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99072F8B4B
	for <lists+linux-nvdimm@lfdr.de>; Sat, 16 Jan 2021 05:39:01 +0100 (CET)
Received: from ml01.vlan13.01.org (localhost [IPv6:::1])
	by ml01.01.org (Postfix) with ESMTP id F37C1100EC1F2;
	Fri, 15 Jan 2021 20:38:59 -0800 (PST)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=67.227.255.162; helo=host.unuhospedagem3.com.br; envelope-from=rcrsolucoesdigitais@gmail.com; receiver=<UNKNOWN> 
Received: from host.unuhospedagem3.com.br (host.unuhospedagem3.com.br [67.227.255.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ml01.01.org (Postfix) with ESMTPS id 95657100ED4A6
	for <linux-nvdimm@lists.01.org>; Fri, 15 Jan 2021 20:38:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=rcranalisesetoriais.com.br; s=default; h=Content-Type:Mime-Version:
	Message-ID:Reply-To:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	 bh=QVHQKn8wgb7j0AtDgPN9IKV5JxJkW9/UKFLTIY8MH4A=; b=dcGGxhIhlMliK8sYTBh8ITP5W
	LnB3VsW2cR/MUPeBRtr/USqsZTtZen6WMUyzDcfzVvKhtvQvp3VphYx3b9len6GZlY0DcyksJ1bdc
	N7IhbyZhE2+eV9/dYdu8i5dsamryqppcOFCNUjCco19BWx34decqHmMo+K2RdcZCwz1zEJXHQTzuU
	YSOSLb4l0TfKlNgrMlhNqzyBd10XLQFoNUStkwJ4noF/RQBsszqFBaWA5wPLQo9PNA9KW0GXTHJWu
	jXVO7RcS7zU+z/IrK7P1rItf3aau8C0QpRXph+xjz9j3PwSnwhskqabVrGto7srqGh7d7obcxJSmq
	il0+lsoEQ==;
Received: from rcranali0 by host.unuhospedagem3.com.br with local (Exim 4.91)
	(envelope-from <rcrsolucoesdigitais@gmail.com>)
	id 1l0dMS-0006j6-Pu; Sat, 16 Jan 2021 01:38:52 -0300
Date: Fri, 15 Jan 2021 23:38:52 -0500
From: =?UTF-8?Q?RCR=20SOLU=C3=87=C3=95ES=20DIGIT?==?UTF-8?Q?AIS?= <rcrsolucoesdigitais@gmail.com>
To: linux-nvdimm@lists.01.org
Subject: =?UTF-8?Q?MENSAGEM=20ENVIADA=20COM?==?UTF-8?Q?=20SUCESSO?= =?UTF-8?Q?!?=
User-Agent: CodeIgniter
X-Sender: rcrsolucoesdigitais@gmail.com
X-Mailer: CodeIgniter
X-Priority: 3 (Normal)
Message-ID: <60026ddcbd96a@gmail.com>
Mime-Version: 1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.unuhospedagem3.com.br
X-AntiAbuse: Original Domain - lists.01.org
X-AntiAbuse: Originator/Caller UID/GID - [504 32007] / [47 12]
X-AntiAbuse: Sender Address Domain - gmail.com
X-Get-Message-Sender-Via: host.unuhospedagem3.com.br: authenticated_id: rcranali0/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: host.unuhospedagem3.com.br: rcranali0
X-Source: /bin/bash
X-Source-Args: sh -c cd '/home/rcranali0/public_html' ; /usr/sbin/sendmail -oi -f rcrsolucoesdigitais@gmail.com -t 
X-Source-Dir: rcranalisesetoriais.com.br:/public_html
Message-ID-Hash: TF6G5CPJMKJH55L2F3EP2VU45DBQIENH
X-Message-ID-Hash: TF6G5CPJMKJH55L2F3EP2VU45DBQIENH
X-MailFrom: rcrsolucoesdigitais@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency; loop; banned-address; member-moderation
X-Content-Filtered-By: Mailman/MimeDel 3.1.1
CC: contato@rcranalisesetoriais.com.br
X-Mailman-Version: 3.1.1
Precedence: list
Reply-To: rcrsolucoesdigitais@gmail.com
List-Id: "Linux-nvdimm developer list." <linux-nvdimm.lists.01.org>
Archived-At: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/message/TF6G5CPJMKJH55L2F3EP2VU45DBQIENH/>
List-Archive: <https://lists.01.org/hyperkitty/list/linux-nvdimm@lists.01.org/>
List-Help: <mailto:linux-nvdimm-request@lists.01.org?subject=help>
List-Post: <mailto:linux-nvdimm@lists.01.org>
List-Subscribe: <mailto:linux-nvdimm-join@lists.01.org>
List-Unsubscribe: <mailto:linux-nvdimm-leave@lists.01.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sua mensagem foi enviada com sucesso!! Nome = E-mail =
linux-nvdimm@lists.01.org Assunto = Mensagem = Entraremos em contato em
breve

_______________________________________________
Linux-nvdimm mailing list -- linux-nvdimm@lists.01.org
To unsubscribe send an email to linux-nvdimm-leave@lists.01.org
